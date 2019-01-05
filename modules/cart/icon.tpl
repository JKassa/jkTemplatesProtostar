{{ 'stylesheet' | jhtml: 'css/style.css' }}

<div id="jk-cart-module" class="{{ class_sfx }}">
	{% capture popover_html %}
	<div class="row-fluid">
		{% if image %}
		<!--Image-->
		<div class="span3">
			<a href="{{ url_cart }}">
				<img alt="cart" src="{{ image }}" title="{{ image_title }}">
			</a>
		</div>
		{% endif %}
		<div class="{% if image %}span9{% else %}span12{% endif %}">
			{% if products %}
			<!--Quantity-->
			<p class="text-center">
				{% capture cart_quantity %}<strong>{{ quantity }}</strong>{% endcapture %}
				{{ 'sprintf' | jtext: 'MOD_JKASSA_CART_COUNT', cart_quantity }}
			</p>
			<!--List products-->
			<ul class="unstyled">
				{% for product in products %}
				<li>
					<a href="{{ product.url }}">
						{{ product.name }}
					</a>
					<!--remove product-->
					<a href="javascript:;" data-click="remove-product" data-index="{{ product.index }}" data-id="{{ product.id }}" title="{{ '_' | jtext: 'MOD_JKASSA_CART_REMOVE' }}">
						<span class="icon-remove text-error" style="font-size:10px"></span>
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
						{% when 'texture' %}
						<span class="minicolors-swatch">
						  <img src="{{ variant.img }}" alt="{{ variant.alt }}" title="{{ variant.title }}">
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
				</li>
				{% endfor %}
			</ul>
			<!--Cart total-->
			<p class="text-center">
				{% capture cart_total %}<strong>{{ total | costDisplay }}{{ currency.symbol }}</strong>{% endcapture %}
				{{ 'sprintf' | jtext: 'MOD_JKASSA_CART_AMOUNT', cart_total }}
			</p>
			{% else %}
			<p class="muted">
				<em>
					{% if text_empty %}
					<!--Text empty-->
					{{ text_empty }}
					{% else %}
					<!--Quantity-->
					{% capture cart_quantity %}<strong>{{ quantity }}</strong>{% endcapture %}
					{{ 'sprintf' | jtext: 'MOD_JKASSA_CART_COUNT', cart_quantity }}
					{% endif %}
				</em>
			</p>
			{% endif %}
		</div>
		{% if products %}
		<!--URLs Go to order & Go to cart-->
		<div class="span12 text-center">
			<hr class="m-t-5 m-b-5">
			<a class="btn btn-small btn-primary" href="{{ url_order }}">
				<i class="icon-arrow-right icon-chevron-right icon-white"></i>
				{{ '_' | jtext: 'MOD_JKASSA_CART_ORDER' }}
			</a>
			<a class="btn btn-small" href="{{ url_cart }}">
				<i class="icon-cart icon-shopping-cart"></i>
				{{ '_' | jtext: 'MOD_JKASSA_CART_CART' }}
			</a>
		</div>
		{% endif %}
	</div>
	{% endcapture %}
	<div class="jk-cart-popover">
		<a href="javascript:;" data-toggle="popover" style="display: block; position: relative; width: 30px; height: 30px">
			<span style="display: block; margin-top: 5px">
				<img alt="cart" src="{{ image }}">
			</span>
			<span style="top: -5px; right: -10px; position: absolute">
				<span class="badge{% if products %} badge-info{% endif %}">{{ quantity }}</span>
			</span>
		</a>
	</div>
	<div class="jk-cart-popover-content" style="display: none;">
		{{ popover_html }}
	</div>
	<script type="text/javascript">
		jQuery(document).ready(function () {
			"use strict";
			jQuery('.jk-cart-popover a').popover({
				html: true,
				placement: 'bottom',
				container: 'body',
				title: "{{ '_' | jtext: 'MOD_JKASSA_CART_YOUR_CART' }}",
				content: function () {
					return jQuery('.jk-cart-popover-content').html();
				}
			}).click(function (e) {
				e.preventDefault();
				jQuery(this).focus();
			});
			jQuery(document).mouseup(function (e) {
				var container = jQuery('.jk-cart-popover');

				if (container.has(e.target).length === 0) {
					jQuery('.jk-cart-popover a').popover('hide');
				}
			});
		});
	</script>
</div>