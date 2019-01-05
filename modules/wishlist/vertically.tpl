{{ 'stylesheet' | jhtml: 'css/style.css' }}

<div id="jk-wishlist-module" class="{{ class_sfx }}">
	{% if image %}
	<!--Wishlist image-->
	<div class="text-center">
	  <a href="{{ url_wishlist }}">
		<img alt="wishlist" src="{{ image }}" title="{{ image_title }}">
	  </a>
	</div>
	{% endif %}

	{% if products %}
	<ul class="thumbnail unstyled m-t-10 p-10">
	  <!--Products-->
	  {% for product in products %}
	  <li class="row-fluid jk-table-body">
		<!--Product Image-->
		<div class="span4">
		  <div class="product-image">
			{% if product.discount %}
			<ul class="stickers">
			  <li>
				<span class="product-label">-{{ product.discount }}</span>
			  </li>
			</ul>
			{% endif %}
			<a href="{{ product.url }}" target="_blank">
			  <img {{ product.image | img_exists: '88x127' }} alt="{{ product.alias }}" title="{{ product.name }}" />
			</a>
		  </div>
		</div>
		<!--Product Information-->
		<div class="span8">
		  <!--Name-->
		  <strong>
			<a href="{{ product.url }}" target="_blank">
			  {{ product.name }}
			</a>
			{% if product.present %}
			<!--present-->
			+
			<a href="{{ product.present.url }}" target="_blank">
			  {{ product.present.name }}
			</a>
			{% endif %}
			{% if product.files %}
			<!--files-->
			<span title="<strong>{{ '_' | jtext: 'COM_JKASSA_ATTACHMENT' }}:</strong><br>{{ product.files | join: '<br>' }}" class="hasTooltip">
			  <span class="icon-flag-2 icon-download"></span>
			</span>
			{% endif %}
		  </strong>

		  {% if product.sku %}
		  <!--SKU (code)-->
		  <div class="muted small text-right m-t-5">
			{{ '_' | jtext: 'MOD_JKASSA_WISHLIST_SKU' }}: {{ product.sku }}
		  </div>
		  {% endif %}

		  {% if product.variants %}
		  <!--Variants-->
		  <div class="small m-t-10">
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
		  </div>
		  {% endif %}

		  <div class="m-t-10">
			<!--Cost-->
			{{ product.cost | costDisplay }}{{ currency.symbol }}

			{% if product.old_cost %}
			<!--Old cost-->
			<del>{{ product.old_cost | costDisplay }}{{ currency.symbol }}</del>
			{% endif %}
		  </div>
		</div>
		<!--Buttons-->
		<div class="span12 text-center m-l-0">
		  <!--remove product-->
		  <a href="javascript:;" class="btn btn-mini btn-danger" data-click="remove-wishlist" data-index="{{ product.index }}" title="{{ '_' | jtext: 'MOD_JKASSA_WISHLIST_REMOVE' }}" data-toggle="tooltip">
			<span class="icon-remove icon-white"></span> {{ '_' | jtext: 'JACTION_DELETE' }}
		  </a>
		</div>
	  </li>
	  {% endfor %}
	</ul>
	{% else %}
	  {% if text_empty %}
	  <!--Text empty wishlist-->
	  <div class="alert alert-info m-t-10">
		{{ text_empty }}
	  </div>
	  {% endif %}
	{% endif %}
</div>