{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}
{{ 'bootstrap.tooltip' | jhtml }}

{% if viewtmpl != 'component' %}
<!--Header-->
<div class="page-header">
  {% if heading %}
  <h1>{{ heading }} <small>({{ quantity }})</small></h1>
  {% else %}
  <h2>{{ title }} <small>({{ quantity }})</small></h2>
  {% endif %}
</div>
{% if pretext %}
<!--Pretext-->
<div>
  {{ pretext }}
</div>
{% endif %}
{% endif %}

<!--Products-->
{% if products %}
{% assign span = tpl_params.span | default_value: 4 %}
{% case span %}
	{% when '12' %}
		{{ '.block-products [class*="span"]:nth-child(1n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when '6' %}
		{{ '.block-products [class*="span"]:nth-child(2n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when '4' %}
		{{ '.block-products [class*="span"]:nth-child(3n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when '3' %}
		{{ '.block-products [class*="span"]:nth-child(4n+1) { margin-left: 0; }' | addStyleDeclaration }}
	{% when '2' %}
		{{ '.block-products [class*="span"]:nth-child(6n+1) { margin-left: 0; }' | addStyleDeclaration }}
{% endcase %}
{% assign prod_height = tpl_params.prod_height | default_value: 279 %}
{% capture prod_height_css %}.thumbnails > li .over-wraper, .thumbnails > li .over-wraper-long { height: {{ prod_height }}px } .thumbnails > li:hover .over-wraper-long { min-height: {{ prod_height }}px }{% endcapture %}
{{ prod_height_css | addStyleDeclaration }}
{% assign img_height = tpl_params.img_height | default_value: 150 %}
{% assign show_stock = tpl_params.prod_stock | default_value: 1 %}
{% assign show_quantity = tpl_params.prod_quantity | default_value: 1 %}
{% include 'html/products/block' %}
{% else %}
<div class="alert alert-block">
  {{ '_' | jtext: 'COM_JKASSA_ACCOUNT_VIEWED_NO_PRODUCTS' }}
</div>
{% endif %}

{% if posttext %}
<!--Posttext-->
<div>
  {{ posttext }}
</div>
{% endif %}