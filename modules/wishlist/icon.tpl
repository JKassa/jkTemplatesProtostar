{{ 'stylesheet' | jhtml: 'css/style.css' }}

<div id="jk-wishlist-module">
	{% capture popover_html %}
	<div class="row-fluid">
		{% if image %}
		<!--Image-->
		<div class="span3">
			<a href="{{ url_wishlist }}">
				<img alt="wishlist" src="{{ image }}" title="{{ image_title }}">
			</a>
		</div>
		{% endif %}
		<div class="{% if image %}span9{% else %}span12{% endif %}">
			{% if products %}
			<ul class="unstyled">
				{% for product in products %}
				<li>
					<a href="{{ product.url }}" target="_blank">
						{{ product.name }}
					</a>
					<!--remove product-->
					<a href="javascript:;" data-click="remove-wishlist" data-index="{{ product.index }}" title="{{ '_' | jtext: 'MOD_JKASSA_WISHLIST_REMOVE' }}">
						<span class="icon-remove text-error" style="font-size:10px"></span>
					</a>
				</li>
				{% endfor %}
			</ul>
			{% else %}
			<p class="muted">
				<em>
					{% if text_empty %}
					{{ text_empty }}
					{% else %}
					{{ '_' | jtext: 'COM_JKASSA_ACCOUNT_WISHLIST_EMPTY' }}
					{% endif %}
				</em>
			</p>
			{% endif %}
		</div>
		{% if products %}
		<!--URLs: Go to wish list & Remove from wishlist-->
		<div class="span12 text-center">
			<hr class="m-t-5 m-b-5">
			<a href="{{ url_wishlist }}" class="btn btn-small">
				<i class="icon-arrow-right icon-chevron-right icon-white"></i>
				{{ '_' | jtext: 'JLIB_HTML_VIEW_ALL' }}
			</a>
			<a href="#" class="btn btn-small btn-danger" data-click="remove-wishlist-all">
				<i class="icon-trash icon-white"></i>
				{{ '_' | jtext: 'JSEARCH_FILTER_CLEAR' }}
			</a>
		</div>
		{% endif %}
	</div>
	{% endcapture %}
	<div class="jk-wishlist-popover">
		<a href="javascript:;" data-toggle="popover" style="display: block; position: relative; width: 30px; height: 30px">
			<span style="display: block; margin-top: 5px">
				<img alt="wishlist" src="{{ image }}">
			</span>
			<span style="top: -5px; right: -10px; position: absolute">
				<span class="badge{% if products %} badge-info{% endif %}">{{ quantity }}</span>
			</span>
		</a>
	</div>
	<div class="jk-wishlist-popover-content" style="display: none;">
		{{ popover_html }}
	</div>
	<script type="text/javascript">
		jQuery(document).ready(function () {
			"use strict";
			jQuery('.jk-wishlist-popover a').popover({
				html: true,
				placement: 'bottom',
				container: 'body',
				title: "{{ '_' | jtext: 'MOD_JKASSA_WISHLIST_YOUR_WISHLIST' }}",
				content: function () {
					return jQuery('.jk-wishlist-popover-content').html();
				}
			}).click(function (e) {
				e.preventDefault();
				jQuery(this).focus();
			});
			jQuery(document).mouseup(function (e) {
				var container = jQuery('.jk-wishlist-popover');

				if (container.has(e.target).length === 0) {
					jQuery('.jk-wishlist-popover a').popover('hide');
				}
			});
		});
	</script>
</div>