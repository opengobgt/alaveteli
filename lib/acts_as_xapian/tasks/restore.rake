# -*- encoding : utf-8 -*-
namespace :xapian do
  namespace :restore do
    desc <<-EOF.strip_heredoc
    Search through all events and add ones that need reindexing to the queue.

    Finds InfoRequestEvents where activity has happened since the restored
    Xapian backup. A START_AT_ID and FINISH_AT_ID can be specified in order to
    iterate through lots of events in parallel:

    #!/bin/sh
    # tmp/parallel_index_events.sh
    START_AT_ID=1  FINISH_AT_ID=25 rake xapian:restore:queue_events_to_reindex &
    START_AT_ID=25 FINISH_AT_ID=50 rake xapian:restore:queue_events_to_reindex &
    # etc…

    wait
    echo "All processes complete"

    The batch size you choose will depend on the number of InfoRequestEvent
    records you have, but we've run this successfully in batches of 250000.
    EOF
    task :queue_events_to_reindex => :environment do
      xapian_backup_date = Time.zone.parse(ENV.fetch('XAPIAN_BACKUP_DATE'))

      start_at = ENV.fetch('START_AT_ID') { InfoRequestEvent.minimum(:id) }
      finish_at = ENV.fetch('FINISH_AT_ID') { InfoRequestEvent.maximum(:id) }

      start_at = Integer(start_at)
      finish_at = Integer(finish_at)

      puts "STARTING_AT: #{start_at}"
      puts "FINISHING_AT: #{finish_at}"

      InfoRequestEvent.where(id: start_at..finish_at).find_each do |event|
        puts "Checking InfoRequestEvent: #{event.id}"

        # Events always have an InfoRequest
        info_request = event.info_request
        # Events always have a PublicBody via the InfoRequest
        public_body = info_request.public_body
        # Ignoring User, because it gets updated_at touched _all the time_

        # We know an event only has one of these, so :
        # * try to fetch them all
        # * compact out the nils
        # * return the first item in the array, which will either be an
        #   associated record or nil
        association = [event.incoming_message,
                       event.outgoing_message,
                       event.comment].compact.first

        # If the association has an updated_at, compare it to the backup date
        # and return a Boolean
        association_needs_reindex =
          if association.respond_to?(:updated_at)
            association.updated_at >= xapian_backup_date
          else
            false
          end

        # If any of the cases are true, we'll want to reindex the event
        needs_reindex = event.created_at >= xapian_backup_date ||
                        info_request.updated_at >= xapian_backup_date ||
                        public_body.updated_at >= xapian_backup_date ||
                        association_needs_reindex

        # Put a job in the reindex queue if we want to reindex the event
        if needs_reindex
          event.xapian_mark_needs_index
        end
      end
    end
  end
end