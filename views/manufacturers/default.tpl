{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}
{{ 'bootstrap.tooltip' | jhtml }}
{% assign options = 'disable_search_threshold' | arrayCombine: 20 %}
{{ 'formbehavior.chosen' | jhtml: 'select', null, options }}

<!--Header-->
<div class="page-header">
  {% if heading %}
  <h1>{{ heading }}</h1>
  {% else %}
  <h2>{{ title }}</h2>
  {% endif %}
</div>

{% if pretext %}
<!--Pretext-->
<div>
  {{ pretext }}
</div>
{% endif %}

<!--List items-->
{% if items %}
<form action="{{ form_action }}" method="post" name="manufacturersForm" id="manufacturersForm">
  
  <fieldset class="filters btn-toolbar clearfix">
    <div class="btn-group pull-right">
      {{ '_' | jtext: 'JGLOBAL_DISPLAY_NUM' }}
      <select onchange="this.form.submit()" name="limit" title="{{ '_' | jtext: 'JSHOW' }}" class="input-medium" style="width: auto;">
        {% for limit in limits %}
          <option value="{{ limit.value }}"{{ limit.selected }}>{{ limit.title }}</option>
        {% endfor %}
      </select>
    </div>
  </fieldset>
  
  <ul class="media-list">
    {% for item in items %}
    <li class="media">
      <a class="pull-left img-polaroid" href="{{ item.url }}">
        <img {{ item.thumbnail | img_exists: '35x35' }} alt="{{ item.alias }}" />
      </a>
      <div class="media-body">
        <h4 class="media-heading">
          <a href="{{ item.url }}">
            {{ item.name }}
          </a>
		  &nbsp;
		  <small class="muted">
			({{ 'plural' | jtext: 'COM_JKASSA_PRODUCTS_QUANTITY', item.products_quantity }})
		  </small>
        </h4>
        {{ item.introtext }}
      </div>
    </li>
    {% endfor %}
  </ul>
  
  {% comment %}
      Pages links (pagination).
      See: html/pagination
  {% endcomment %}
  {{ pagesLinks }}
</form>
{% else %}
<div class="alert alert-block">
  {{ no_items }}
</div>
{% endif %}

{% if posttext %}
<!--Posttext-->
<div>
  {{ posttext }}
</div>
{% endif %}

{% comment %}
    Connecting comments plugin.
    See: Plugin Manager: Plugins -> jkcomments.
{% endcomment %}
{{ Itemid | jkcomments: title }}