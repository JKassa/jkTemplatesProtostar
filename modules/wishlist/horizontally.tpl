{{ 'stylesheet' | jhtml: 'css/style.css' }}

<div id="jk-wishlist-module" class="{{ class_sfx }}">
	{% if products %}
	<div class="row-fluid mjkblock">
	  <ul class="thumbnails">
		{% for product in products %}
		<li class="span3 thumbnail {% if product.active %}active{% endif %}">
		  <div style="height: 145px">
			{% if product.image %}
			<div class="product-image" style="text-align: center">
			  <a href="{{ product.url }}" title="{{ product.name }}">
				<img src="{{ product.image }}" alt="{{ product.alias }}" style="max-height: 75px; max-width: 75px" />
			  </a>
			</div>
			{% endif %}
			<div class="caption">
			  <div style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap">
				<a href="{{ product.url }}" title="{{ product.name }}">
				  {{ product.name }}
				</a>
			  </div>
			  {% if product.introtext %}
			  <div class="m-t-5" style="font-size: 11px; line-height: 14px">
				  {{ product.introtext | truncateDesc: 35 }}
			  </div>
			  {% endif %}
			  {% if product.old_cost %}
			  <del>{{ product.old_cost | costDisplay }}{{ currency.symbol }}</del>
			  {% endif %}
			</div>
		  </div>
		  <div class="caption">
			{% if product.cost %}
			<div class="m-t-5">
			  <span class="cost">
				<span>{{ product.cost | costDisplay }}</span>{{ currency.symbol }}
			  </span>
			</div>
			{% endif %}
			<!--Buttons-->
			<div class="span12 text-center m-l-0">
			  <!--remove product-->
			  <a href="javascript:;" class="btn btn-mini btn-danger" data-click="remove-wishlist" data-index="{{ product.index }}" title="{{ '_' | jtext: 'MOD_JKASSA_WISHLIST_REMOVE' }}" data-toggle="tooltip">
				<span class="icon-remove icon-white"></span> {{ '_' | jtext: 'JACTION_DELETE' }}
			  </a>
			</div>
		  </div>
		</li>
		{% endfor %}
	  </ul>
	</div>
	{% else %}
	  {% if text_empty %}
	  <!--Text empty wishlist-->
	  <div class="alert alert-info m-t-10">
		{{ text_empty }}
	  </div>
	  {% endif %}
	{% endif %}
</div>