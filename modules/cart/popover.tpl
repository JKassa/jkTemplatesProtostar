{{ 'stylesheet' | jhtml: 'css/style.css' }}

{% comment %}
  HTML code for the popover window.
{% endcomment %}
{% if image %}
  {% assign span = 'span9' %}
{% else %}
  {% assign span = 'span12' %}
{% endif %}

<div id="jk-cart-module">
	{% capture popover_html %}
	<div class="row-fluid">
	  {% if image %}
	  <!--Cart image-->
	  <div class="span3 text-center">
		<img alt="cart" src="{{ image }}" title="{{ image_title }}">
	  </div>
	  {% endif %}
	  {% if products %}
	  <div class="{{ span }}">
		<!--Quantity-->
		<p class="text-center">
		  {% capture cart_quantity %}<strong>{{ quantity }}</strong>{% endcapture %}
		  {{ 'sprintf' | jtext: 'MOD_JKASSA_CART_COUNT', cart_quantity }}
		</p>
		<!--List products-->
		<ol>
		  {% for product in products %}
		  <li>
			<a href="{{ product.url }}">
			  {{ product.name }}
			</a>

			{% if product.variants %}
			<br>
			<small>
			  {% for variant in product.variants %}
				{{ variant.name }}:
				{% case variant.type %}
				{% when 'radio' %}
				<span class="variant-radio-value">
				  {{ variant.value }}
				</span>
				{% when 'color' %}
				<span class="minicolors-swatch">
				  <span style="background-color: {{ variant.value }};" title="{{ variant.title }}"></span>
				</span>
				{% when 'select' %}
				<span>
				  {{ variant.value }}
				</span>
				{% endcase %}
			  {% endfor %}
			</small>
			{% endif %}

			<br>
			{% if product.old_cost %}
			<!--old cost-->
			<del>{{ product.old_cost | costDisplay }}{{ currency.symbol }}</del>
			{% endif %}
			<!--cost-->
			<strong>{{ product.cost | costDisplay }}{{ currency.symbol }}</strong>
			<small>({{ product.quantity }})</small>
			<!--remove product-->
			<a href="javascript:;" data-click="remove-product" data-index="{{ product.index }}" data-id="{{ product.id }}" title="{{ '_' | jtext: 'MOD_JKASSA_CART_REMOVE' }}" data-toggle="tooltip"><span class="icon-remove text-error" style="font-size:10px"></span></a>
		  </li>
		  {% endfor %}
		</ol>
		<!--Cart total-->
		<p class="text-center">
		  {% capture cart_total %}<strong>{{ total | costDisplay }}{{ currency.symbol }}</strong>{% endcapture %}
		  {{ 'sprintf' | jtext: 'MOD_JKASSA_CART_AMOUNT', cart_total }}
		</p>
	  </div>
	  <!--URL order & cart-->
	  <div class="span12 text-center">
		<a class="btn btn-small btn-primary" href="{{ url_order }}">
		  <i class="icon-arrow-right icon-chevron-right icon-white"></i> {{ '_' | jtext: 'MOD_JKASSA_CART_ORDER' }}
		</a>
		<a class="btn btn-small" href="{{ url_cart }}">
		  <i class="icon-cart icon-shopping-cart"></i> {{ '_' | jtext: 'MOD_JKASSA_CART_CART' }}
		</a>
	  </div>
	  {% else %}
	  <div class="{{ span }}">
		<!--Quantity-->
		<p class="text-center">
		  {% capture cart_quantity %}<strong>{{ quantity }}</strong>{% endcapture %}
		  {{ 'sprintf' | jtext: 'MOD_JKASSA_CART_COUNT', cart_quantity }}
		</p>
		{% if text_empty %}
		<!--Text empty cart-->
		<div class="alert alert-info">
		  {{ text_empty }}
		</div>
		{% endif %}
	  </div>
	  {% endif %}
	</div>
	{% endcapture %}

	<div class="jk-cart-popover">
	  <a data-toggle="popover" href="javascript:;" class="btn btn-inverse btn-mini">
		{{ '_' | jtext: 'MOD_JKASSA_CART_CART' }}
		<span class="icon-shopping-cart icon-cart icon-white"></span> ({{ quantity }})
	  </a>
	</div>
	<div class="jk-cart-popover-content" style="display: none;">
	  {{ popover_html }}
	</div>
	
	<script type="text/javascript">
	  jQuery(document).ready(function()
	  {
		  "use strict";

		  jQuery('.jk-cart-popover a').popover({
			  html: true,
			  placement: 'bottom',
			  container: 'body',
			  title: '{{ image_title }}',
			  content: function () { return jQuery('.jk-cart-popover-content').html(); }
		  }).click(function(e) { e.preventDefault(); jQuery(this).focus(); });

		  jQuery(document).mouseup(function (e)
		  {
			  var container = jQuery('.jk-cart-popover');

			  if (container.has(e.target).length === 0) {
				  jQuery('.jk-cart-popover a').popover('hide');
			  }
		  });
	  });
	</script>
</div>