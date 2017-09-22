---
layout: page
title: Themes
---

# Alaveteli's themes

<p class="lead">
    Alaveteli uses <strong>themes</strong> to make the site look and run
    differently from the default.
    Simple changes like colour and logo are relatively easy, but themes can also
  control more complex things like <em>how</em> the site behaves.
</p>

When you customise your Alaveteli site, there is a lot you can change just
by editing the [config settings]({{ page.baseurl }}/docs/customising/config/).
But if you want to change the way the site looks, or add more specific
behaviour, you'll need to make a **theme**.

<div class="attention-box info">
  A theme is the way you tell Alaveteli which parts of your site look and behave
  differently from the core site. These differences are implemented as a
  collection of files (separate from the core Alaveteli source code), which
  Alaveteli uses to override its default code.
</div>

You don't need to be a programmer in order to make simple changes, but you will
need to be confident enough to copy and change some files. If you're not sure
about this, [ask for help](/community/)!

The easiest way to create a new theme is to
**[follow these steps]({{ page.baseurl }}/docs/customising/make_a_new_theme)**.

<div class="attention-box warning">
  When you customise Alaveteli, you should <strong>always use this
  theme mechanism</strong> instead of editing the core Alaveteli files. If you
  do not &mdash; that is, if you make custom changes to the main Alaveteli
  source code &mdash; you may not be able to update your site with newer
  Alaveteli code (new features and occassional bugfixes).
  <p>
    <em>Sometimes</em> you may want to change the core templates in a way that
    would benefit everyone, in which case: great! But please discuss the changes
    on the mailing list first, make them in a fork of Alaveteli, and then issue
    a pull request.
  </p>
</div>

## Your theme is a separate repo


We use
<a href="{{ page.baseurl }}/docs/glossary/#git" class="glossary__link">git</a>
to manage Alaveteli's source code, and Alaveteli expects your theme to be in
a git repository of its own.

Although you *can* start customising your site on your
<a href="{{ page.baseurl }}/docs/glossary/#development" class="glossary__link">development server</a>
by playing with the `alavetelitheme` theme that Alaveteli ships with, we recommend
you make it into your own repo as soon as you can. If you're seriously customising
&mdash; and certainly before you can deploy to a
<a href="{{ page.baseurl }}/docs/glossary/#production" class="glossary__link">production server</a> &mdash;
you must do this. Make sure you choose a unique name for your theme (and hence its
repo). If your site is `abcexample.com`, we suggest you call your theme
something like `abcexample-theme`.

Alaveteli's `themes:install` rake task, which installs themes, works by
getting the git repo from the URL specified in the config setting
[`THEME_URLS`]({{ page.baseurl }}/docs/customising/config/#theme_urls). This is
why your theme must be in its own git repo.

The easiest way to create a new theme is to
**[follow these steps]({{ page.baseurl }}/docs/customising/make_a_new_theme)**.

<div class="attention-box info">
  Here's an example of a complex theme in action: see the theme repo at
  <a href="https://github.com/mysociety/whatdotheyknow-theme">https://github.com/mysociety/whatdotheyknow-theme</a>.
  This is the theme for UK's Alaveteli instance
  <a href="{{ page.baseurl }}/docs/glossary/#wdtk" class="glossary__link">WhatDoTheyKnow</a>.
  You can see it
  <a href="https://www.whatdotheyknow.com">deployed on the WhatDoTheyKnow website</a>.
  This happens because the WhatDoTheyKnow server has this setting in <code>config/general.yml</code>:
  </p>
  <pre><code>THEME_URLS:
  - 'git://github.com/mysociety/whatdotheyknow-theme.git'</code></pre>
</div>

## What you might want to change

The most common requirement is to brand the site: at a minimum,
[inserting your own logo](#changing-the-site-logo) and
[colour scheme](#changing-the-colour-scheme). You should also
[add the categories](#adding-your-own-categories-for-authorities)
that authorities can appear in (you can see these as groupings on the left-hand
side of the [View authorities](https://www.whatdotheyknow.com/body/list/all) page
on <a href="{{ page.baseurl }}/docs/glossary/#wdtk" class="glossary__link">WhatDoTheyKnow</a>).
You may also want to
[tweak the different states](#customising-the-request-states) that a request can
go through.

There may also be other things you want to customise -- talk to us on the
developer's mailing list to discuss what you need. We're happy to help work out
the best way of doing customisation and it's even possible that what you want
has already been done in someone else's theme.

The important principle to bear in mind is that the less you override and
customise the code, the easier your site will be to maintain in the long term.
Any customisation is possible, but for each customisation beyond the simple
cases documented here, ask yourself (or your client), "can we possibly live
without this?" If the answer is "no", then always ask on the mailing list about
a pluggable way of achieving your goals before you override any of the core
code.

## General principles

We try to encapsulate all site-specific functionality in one of these
places:

* **site configuration**<br>
  use the [config settings]({{ page.baseurl }}/docs/customising/config/)
  for example, the name of your site, the available languages, and so on.
  You change these by editing `config/general.yml`.
* **data**<br>
  for example, the public authorities to whom requests should be addressed,
  and the tags and categories for grouping them. You control all this
  through the
  <a href="{{ page.baseurl }}/docs/glossary/#admin_interface" class="glossary__link">admin
  interface</a>: see the [admin manual]({{ page.baseurl }}/docs/running/admin_manual).
* **a theme**<br>
  installed in `lib/themes`.
  The page you're reading now is all about what you can do in a theme.

By default, Alaveteli ships with the sample theme (`alavetelitheme`), so your
`config/general.yml` contains this:

    THEME_URLS:
      - 'git://github.com/mysociety/alavetelitheme.git'

You can also install the theme by hand, by running:

    bundle exec rake themes:install

This installs whichever theme is specified by the
[`THEME_URLS`]({{ page.baseurl }}/docs/customising/config/#theme_urls)
setting.

The sample theme contains examples for nearly everything you might
want to customise.  We recommend you make a copy, rename it, and
use that as the basis for your own theme.

<div class="attention-box info">
  The
  <code><a href="{{ page.baseurl }}/docs/customising/config/#theme_urls">THEME_URLS</a></code>
  setting allows you to specifiy more than one theme &mdash; but
  normally you only need one.
</div>

## Make sure your theme is as lightweight as possible

The more you put in your theme, the harder it will be to upgrade to future
versions of Alaveteli.

Everything you place in your theme overrides things in the core theme, so if
you make a new "main template", then new widgets that appear in the core theme
won't appear on your website. If you want them, you'll need to manually update
your version of the template to include them, and potentially you'll need to
do this every time the core theme changes.

Therefore, you should consider how you can brand your website by changing
as little in the core theme as possible. An extreme -- but not impossible --
way to do this is to rebrand the site by only changing the CSS, because this
means *none* of the templates are being overridden.

However, even with minimal customisation, you must also add custom help pages
(described below). Alaveteli's default help pages are deliberately incomplete.
We know that every installation is going to be operating in different
circumstances, so a generic help text cannot be useful. You must write your
own, for your own users.

## Branding the site

The core templates define the layout and user interface of an Alaveteli site.
They are in `app/views/` and use
<a href="{{ page.baseurl }}/" class="glossary__link">Rails</a>'
ERB syntax. For example, the template for the home page lives at
`app/views/general/frontpage.html.erb`, and the template for the "about us"
page is at `app/views/help/about.html.erb`.

As described above, although you *could* edit those core files directly, this
would be a Bad Idea, because you would find it increasingly hard to do upgrades.

Instead, you should override these pages *in your own theme*, by placing them
at a corresponding location within your theme's `lib/` directory.  For example,
this means that if you put your own copy of the "about us" template
in <code>lib/themes/<em>yourtheme</em>/lib/views/help/about.html.erb</code>,
then that will appear instead of the core "about us" file.

### Changing the site logo

Alaveteli uses Rails' [asset pipeline](http://guides.rubyonrails.org/asset_pipeline.html)
to convert and compress stylesheets written in
<a href="{{ page.baseurl }}/docs/glossary/#sass" class="glossary__link">Sass</a>
into minified concatenated CSS. Assets are stored in core Alaveteli under
`app/assets` -- in `fonts`, `images`, `javascripts` and `stylesheets`. The
default theme has corresponding asset directories in `alavetelitheme/assets`
Asset files placed in these directories will override those in the core
directories.

To add your own logo, you will need to prepare 2 separate logo files - the
"standard" one and a double size version that will prevent your logo
looking blurry on high resolution screens such as Apple's Retina displays.

The easiest method is to start with a logo image which is exactly twice
the size you want it to appear on the screen (if you try to create the larger version
from the smaller one, you run the risk of ending up with ending up with your
larger file looking blurry anyway). So if you want your finished logo to be 275
pixels wide and 44 pixels high (as per our current example logos), your
high resolution version should be 550 pixels by 88. Save this as `logo@2.png`
and copy it to your theme as
<code>lib/themes/<em>yourtheme</em>/assets/images/logo@2.png</code> so that it
will replace the example image.

Now make a copy of your `logo@2.png` and make it half the size - be careful to
keep the proportions the same or your logo will look squashed! - so in our example
it will be 275 x 44 pixels. Save this as `logo.png` and place it in your theme as
<code>lib/themes/<em>yourtheme</em>/assets/images/logo.png</code>.

#### A logo for social media sharing

There is a third version of the logo that is used for Facebook's Open Graph
metadata so that content shared on Facebook will have your logo displayed
alongside it. This logo needs to be square, at a minimum size of
256 x 256 pixels and should be placed in your theme as
<code>lib/themes/<em>yourtheme</em>/assets/images/logo-opengraph.png</code>.


### Changing the colour scheme

Alaveteli uses a set of basic
<a href="{{ page.baseurl }}/docs/glossary/#sass" class="glossary__link">Sass</a>
modules to define the layout for the site on different device sizes, and some
basic styling. These modules are in `app/assets/stylesheets/responsive`. The
colours and fonts are added in the theme -- `alavetelitheme` defines them in
`lib/themes/alavetelitheme/assets/stylesheets/responsive/custom.scss`. Colours
used in the theme are defined as variables at the top of this file and you can
edit them in your version of this file in your own theme.

### Changing other styling

To change other styling, you can add to or edit the styles in
`lib/themes/alavetelitheme/assets/stylesheets/responsive/custom.scss`.
Styles defined here will override those in the sass modules in
`app/assets/stylesheets/responsive` as they will be imported last by
`app/assets/stylesheets/responsive/all.scss`. However, if you want to
substantially change the way a particular part of the site is laid out,
you may want to override one of the core Sass modules. You could override the
layout of the front page, for example, by copying
`app/assets/stylesheets/responsive/_frontpage_layout.scss` to
<code>lib/themes/<em>yourtheme</em>/assets/stylesheets/responsive/_frontpage_layout.scss</code>
and editing it.

You can load extra stylesheets and javascript files by adding them to
<code>lib/themes/<em>yourtheme</em>/lib/views/general/_before_head_end.html.erb</code>

## Adding your own categories for authorities

You should add
<a href="{{ page.baseurl }}/docs/glossary/#category" class="glossary__link">categories</a>
for the authorities on your site -- Alaveteli will display the authorities grouped
by categories if you have set any up. Alaveteli uses
<a href="{{ page.baseurl }}/docs/glossary/#tag" class="glossary__link">tags</a>
to assign authorities to the right categories, but you should add tags anyway
because they are also used by the site's search facility. Together, categories
and tags help your users find the right authority for their request.

You can set all this up using the
<a href="{{ page.baseurl }}/docs/glossary/#admin_interface" class="glossary__link">admin interface</a>.
See [more about categories and tags]({{ page.baseurl }}/docs/running/categories_and_tags/)
for details.

## Customising the request states

As mentioned above, if you can possibly live with the
[default Alaveteli request statuses]({{ page.baseurl }}/docs/customising/states/),
it would be good to do so.  You can set how many days must pass before
a request is considered "overdue" in the main site config file &mdash;
see [`REPLY_LATE_AFTER_DAYS`]({{ page.baseurl }}/docs/customising/config/#reply_late_after_days).

If you can't live with the states as they are, there's a very basic way to add
to them (we're working on this, so it will be improved over time). Currently,
there's no easy way to remove any. There is an example of how to do this in the
`alavetelitheme`.

To do add states, create two modules in your theme,
`InfoRequestCustomStates` and `RequestControllerCustomStates`.

`InfoRequestCustomStates` must have these methods:

* `theme_calculate_status`: return a tag to identify the current state of the request
* `theme_extra_states`: return a list of tags which identify the extra states you'd like to support
* `theme_display_status`: return human-readable strings corresponding with these tags

`RequestControllerCustomStates` must have one method:

* `theme_describe_state`: return a notice for the user suitable for
  displaying after they've categorised a request; and redirect them to
  a suitable next page

When you've added your extra states, you also need to create the following files
in your theme:

* `lib/views/general/_custom_state_descriptions.html.erb`: Descriptions
  of your new states, suitable for displaying to end users
* `lib/views/general/_custom_state_transitions_complete.html.erb`:
  Descriptions for any new states that you might characterise as
  'completion' states, for displaying on the categorisation form that
  we ask requestors to fill out
* `lib/views/general/_custom_state_transitions_pending.html.erb`: As
  above, but for new states you might characterise as *pending*
  states.

You can see examples of these customisations in
[this commit](https://github.com/sebbacon/informatazyrtare-theme/commit/2b240491237bd72415990399904361ce9bfa431d)
for the Kosovan version of Alaveteli, Informata Zyrtare (ignore the
file `_custom_state_transitions.html.erb`, which is
unused).

## Customising the help pages

The help pages are a really important part of an Alaveteli site. If you're running Alaveteli in another language, you'll want to show
your users localised versions of the help pages. Even if you're running
the site in English, the default help pages in Alaveteli are taken from
WhatDoTheyKnow, and are therefore in some places relevant only to the UK. You should
take these pages as inspiration, but review their content with a view to
your jurisdiction.

The important pages to customise and translate are listed here. We note where Alaveteli links to these pages (sometimes to anchors for particular sections within the pages) or takes users directly to them. You can check whether your theme has all the required pages
and sections by running `bundle exec rake themes:check_help_sections`.

* [about](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/about.html.erb): why the website exists, why it works, etc. When a user starts to make a request in Alaveteli, they are referred to the section here on [why authorities should respond to requests](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/about.html.erb#L29).

* [alaveteli](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/alaveteli.html.erb): about the Alaveteli framework.

* [api](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/api.html.erb): information about the site's Application Programming Interface (API).

* [contact](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/contact.html.erb): how to get in touch.

* [credits](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/credits.html.erb): who is involved in the site.  Importantly, includes [a section](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/credits.html.erb#L15) on how users can help the project. Users are referred to this section if they categorise all the requests in the [categorisation game]({{ page.baseurl }}/docs/glossary/#categorisation-game).

* [officers](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/officers.html.erb): information for the officers who deal with FOI at authorities.  They get a link to this page in emails that the site sends them.

* [privacy](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/privacy.html.erb): privacy policy, plus information making it clear that requests are going to appear on the internet.  Let users know if they are allowed to use pseudonyms in your jurisdiction. Users are referred to the [section on this page](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/privacy.html.erb#L109) about what to do if the authority says they only have a paper copy of the information requested if the user classifies their request as ['gone postal']({{ page.baseurl }}/docs/customising/states/#gone_postal).

* [requesting](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/requesting.html.erb): the main help page about making requests.  How it works, how to decide who to write to, what they can expect in terms of responses, how to make appeals, etc. Users are referred to the [section on how quickly a response to their request should arrive](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/requesting.html.erb#L125) when their request is overdue for a response. They are referred to the [section on what to do if the Alaveteli site isn't showing the authority they want to request information](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/requesting.html.erb#L30) from the page that allows them to list and search authorities.

* [unhappy](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/unhappy.html.erb): users are taken to this page after a request that has been somehow unsuccessful (e.g. the request has been refused, or the authority is insisting on a postal request).  The page should encourage them to keep going, e.g. by starting a new request or addressing it to a different body. In particular users are referred to the [section on using other means](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/unhappy.html.erb#L83) to get their question answered. If the user has requested an internal review of their request, they are referred to [the section on this page](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/unhappy.html.erb#L28) that describes the law relating to how long a review should take.

* [why email](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/_why_they_should_reply_by_email.html.erb): a snippet of information that explains why users should insist on replies by email.  This is displayed next to requests that have ["gone postal"]({{ page.baseurl }}/docs/customising/states/#gone_postal) - where the authority has asked for the user's physical address so that they can reply with a paper response.

* [sidebar](https://github.com/mysociety/alavetelitheme/blob/master/lib/views/help/_sidebar.html.erb): a menu for the help pages with a link to each one. You should customise this so that it includes any extra help pages you add, and doesn't include any you remove.

You can add your own help pages to your site by replacing the default
pages in your theme with your own versions, using a locale suffix for
each page to indicate what language the page is written in. No locale
suffix is needed for pages written for the [default locale]({{ page.baseurl }}/docs/customising/config/#default_locale) for the site.
For example, [alavetelitheme contains help
pages](https://github.com/mysociety/alavetelitheme/tree/master/lib/views/help)
for the default 'en' locale. If no
help page exists in the theme for a particular page in the locale that
the site is being viewed in, the default help page in English will be
shown.


## Adding new pages in the navigation

You can extend the base routes in Alaveteli by modifying
<code>lib/themes/<em>yourtheme</em>/lib/config/custom-routes.rb</code>.
The example in `alavetelitheme` adds an extra help page. You can also use this
to override the behaviour of specific pages if necessary.

## Adding or overriding models and controllers

If you need to extend the behaviour of Alaveteli at the controller or model
level, see `alavetelitheme/lib/controller_patches.rb` and
`alavetelitheme/lib/model_patches.rb` for examples.

## Quickly switching between themes

On your
<a href="{{ page.baseurl }}/docs/glossary/#development" class="glossary__link">development server</a>,
you can use
[`script/switch-theme.rb`](https://github.com/mysociety/alaveteli/blob/master/script/switch-theme.rb)
to set the current theme if you are working with multiple themes. This can be
useful for switching between the default `alavetelitheme` and your own fork.

## Testing your theme

You can add tests for the changes in functionality that are implemented
in your theme. These use <a href="http://rspec.info/">rspec</a>, as does the main Alaveteli test suite.
They should be put in the `spec` directory of your theme. They are run
separately from the main Alaveteli tests by executing the following command in the directory in which Alaveteli is installed (substituting your theme directory for `alavetelitheme`):

    bundle exec rspec lib/themes/alavetelitheme/spec

You can see some example tests in the <a href="https://github.com/mysociety/whatdotheyknow-theme/tree/master/spec">whatdotheyknow-theme</a>.