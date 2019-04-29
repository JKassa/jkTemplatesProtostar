{% comment %}
	Connect CSS and JavaScript to the header of the document
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}
{{ 'bootstrap.tooltip' | jhtml }}
{% assign options = 'disable_search_threshold' | arrayCombine: 20 %}
{{ 'formbehavior.chosen' | jhtml: 'select', null, options }}

{% if heading %}
<!--Heading-->
<div class="page-header">
  <h1>{{ heading }}</h1>
</div>
{% endif %}

<!--Image-->
<div>
  <img {{ logo | img_exists: '400x120' }} alt="{{ alias }}">
</div>

<div class="row-fluid page-header m-t-30">
  <div class="span7">
    <!--Name-->
    <h2 class="m-t-0">
      {{ name }}
      <small class="muted">{{ 'plural' | jtext: 'COM_JKASSA_PRODUCTS_QUANTITY', products_quantity }}</small>
    </h2>
  </div>
  <div class="span5 text-right">
    {% comment %}
        Connecting voting plugin.
        See: Plugin Manager: Plugins -> jkvotes.
    {% endcomment %}
    {% assign votes = id | jkvotes: rating, rating_count %}
    {% if votes %}
    <!--Rating-->
    {{ votes }}
    {% endif %}
  </div>
</div>

<!--Layout products-->
{{ products }}

{% if fulltext %}
<!--Fulltext-->
<div class="m-t-10">
  {{ fulltext }}
</div>
{% endif %}

{% if contacts %}
<!--Contacts-->
<div>
  <h4>
    {{ '_' | jtext: 'COM_JKASSA_MANUFACTURER_CONTACTS' }}
  </h4>
  <ul class="unstyled">
    {% if contacts.url %}
    <!--homepage-->
    <li title="{{ '_' | jtext: 'COM_JKASSA_MANUFACTURER_HOMEPAGE' }}">
      <span class="icon-home"></span>
      <a href="{{ contacts.url }}" target="_blank">{{ '_' | jtext: 'COM_JKASSA_MANUFACTURER_HOMEPAGE' }}</a>
    </li>
    {% endif %}
    {% if contacts.email %}
    <!--email-->
    <li title="{{ '_' | jtext: 'JGLOBAL_EMAIL' }}">
      <span class="icon-mail icon-envelope"></span>
      <a href="mailto:{{ contacts.email }}">{{ contacts.email }}</a>
    </li>
    {% endif %}
    {% if contacts.support %}
    <!--support-->
    <li title="{{ '_' | jtext: 'COM_JKASSA_MANUFACTURER_SUPPORT' }}">
      <span class="icon-mail icon-envelope"></span>
      <a href="{{ contacts.support }}" target="_blank">{{ '_' | jtext: 'COM_JKASSA_MANUFACTURER_SUPPORT' }}</a>
    </li>
    {% endif %}
    {% if contacts.phone %}
    <!--phone-->
    <li title="{{ '_' | jtext: 'COM_JKASSA_PHONE' }}">
      <span class="icon-address icon-headphones"></span>
      {{ contacts.phone }}
    </li>
    {% endif %}
    {% if contacts.fax %}
    <!--fax-->
    <li title="{{ '_' | jtext: 'COM_JKASSA_MANUFACTURER_FAX' }}">
      <span class="icon-printer icon-print"></span>
      {{ contacts.fax }}
    </li>
    {% endif %}
  </ul>
</div>
{% endif %}

{% comment %}
    Connecting social plugin.
    See: Plugin Manager: Plugins -> jksocial.
{% endcomment %}
{% assign social = id | jksocial: name, logo, metadesc, return_url %}
{% if social %}
{{ social }}
{% endif %}

{% comment %}
    Connecting comments plugin.
    See: Plugin Manager: Plugins -> jkcomments.
{% endcomment %}
{{ id | jkcomments: name }}

<!--Print / Email / Edit-->
{% if print_screen == 0 %}
<div class="btn-group pull-right m-t-15 m-r-5">
  <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
    <span class="icon-cog"></span>
    <span class="caret">&nbsp;</span>
  </a>
  <ul class="dropdown-menu actions">
    <li class="print-icon">{{ print_icon }}</li>
    <li class="email-icon">{{ email_icon }}</li>
    {% if edit_icon %}
    <li class="edit-icon">{{ edit_icon }}</li>
    {% endif %}
  </ul>
</div>
{% else %}
<div class="btn no-print" style="position: fixed; right: 10px; top: 10px">
  {{ print_screen }}
</div>
{% endif %}

<!--Details-->
<ul class="breadcrumb">
  <li>
    <span class="icon-user"></span>
    {{ 'sprintf' | jtext: 'COM_JKASSA_WRITTEN_BY', '' }}
    {% if contact_link %}
    <a href="{{ contact_link }}">{{ author }}</a>
    {% else %}
    {{ author }}
    {% endif %}
    <span class="divider">|</span>
  </li>
  <li>
    <span class="icon-calendar"></span>
    <time>
      {% assign date_publish = 'date' | jhtml: publish, 'DATE_FORMAT_LC2' %}
      {{ 'sprintf' | jtext: 'COM_JKASSA_PUBLISHED_DATE_ON', date_publish }}
    </time>
    <span class="divider">|</span>
  </li>
  <li>
    <span class="icon-calendar"></span>
    <time>
      {% assign date_created = 'date' | jhtml: created, 'DATE_FORMAT_LC2' %}
      {{ 'sprintf' | jtext: 'COM_JKASSA_CREATED_DATE_ON', date_created }}
    </time>
    <span class="divider">|</span>
  </li>
  <li>
    <span class="icon-calendar"></span>
    <time>
      {% assign date_modified = 'date' | jhtml: modified, 'DATE_FORMAT_LC2' %}
      {{ 'sprintf' | jtext: 'COM_JKASSA_LAST_UPDATED', date_modified }}
    </time>
  </li>
</ul>

{% if pagination %}
<!--Pagination-->
<ul class="pager pagenav">
  {% if pagination.prev %}
  <li class="previous">
    <a href="{{ pagination.prev }}" rel="prev">
      <span class="icon-arrow-left icon-chevron-left"></span> {{ '_' | jtext: 'JPREV' }}
    </a>
  </li>
  {% endif %}
  {% if pagination.next %}
  <li class="next">
    <a href="{{ pagination.next }}" rel="next">
      {{ '_' | jtext: 'JNEXT' }} <span class="icon-arrow-right icon-chevron-right"></span>
    </a>
  </li>
  {% endif %}
</ul>
{% endif %}