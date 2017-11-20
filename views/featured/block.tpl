{% assign span = tpl_params.f_span | default_value: 4 %}
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
{% assign prod_height = tpl_params.f_prod_height | default_value: 279 %}
{% capture prod_height_css %}.thumbnails > li .over-wraper, .thumbnails > li .over-wraper-long { height: {{ prod_height }}px } .thumbnails > li:hover .over-wraper-long { min-height: {{ prod_height }}px }{% endcapture %}
{{ prod_height_css | addStyleDeclaration }}
{% assign img_height = tpl_params.f_img_height | default_value: 150 %}
{% assign show_stock = tpl_params.f_prod_stock | default_value: 1 %}
{% assign show_quantity = tpl_params.f_prod_quantity | default_value: 1 %}
{% include 'html/products/block' %}