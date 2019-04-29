<ul class="unstyled mjklist">
  {% for product in products %}
  <li>
    {% if product.image %}
    <div class="m-b-5 m-t-5">
      <a href="{{ product.url }}">
        <img src="{{ product.image }}" alt="{{ product.alias }}" style="{{ img_width_height }}" />
      </a>
    </div>
    {% endif %}
    <a href="{{ product.url }}">
      {{ product.name }}
    </a>
    {% if product.introtext %}
    <div class="m-b-5 m-t-5" style="font-size: 11px; line-height: 14px">
        {{ product.introtext | truncateDesc: 100 }}
    </div>
    {% endif %}
	{% if show_stock %}
	<!--Stock-->
	<div class="muted m-b-5 m-t-5 text-right small">
	  {% case product.stock %} 
	  {% when 0 %}
	  <!--Not available-->
	  {{ '_' | jtext: 'COM_JKASSA_STOCK_0' }}
	  {% when '-1' %}
	  <!--Available-->
	  {{ '_' | jtext: 'COM_JKASSA_STOCK_1' }}
	  {% when '-2' %}
	  <!--Under the order-->
	  {{ '_' | jtext: 'COM_JKASSA_STOCK_2' }}
	  {% else %}
	  <!--Number-->
	  {{ '_' | jtext: 'COM_JKASSA_STOCK' }}: {{ product.stock }}
	  {% endcase %}
	</div>
	{% endif %}
	{% if show_votes %}
	{% comment %}
		Rating reviews JKassa or Plug-in voting (See: Plugin Manager: Plugins -> jkvotes).
	{% endcomment %}
	{% if reviews_included %}
	  <!--Rating reviews-->
	  <div class="text-right m-b-5 m-t-5" title="{{ 'plural' | jtext: 'COM_JKASSA_REVIEWS_COUNT', product.rating_count }}">
		{% for i in (1..5) %}
		  {% if product.rating >= i %}
		  <span class="icon-star" style="color: #F2CD00"></span>
		  {% else %}
		  <span class="icon-star-empty" style="color: #CCCCCC"></span>
		  {% endif %}
		{% endfor %}
	  </div>
	{% else %}
	  {% assign votes = product.id | jkcountervotes: product.rating, product.rating_count %}
	  {% if votes %}
	  <!--Voting-->
	  <div class="text-right m-b-5 m-t-5">
		{{ votes }}
	  </div>
	  {% endif %}
	{% endif %}
	{% endif %}
    {% if product.cost %}
    <div class="m-b-5 m-t-5">
      {% if product.old_cost %}
      <del>{{ product.old_cost }}{{ currency.symbol }}</del>
      {% endif %}
      <span class="cost">
        <span>{{ product.cost | costDisplay }}</span>{{ currency.symbol }}
      </span>
    </div>
    {% endif %}
    {% if btns %}
    <div class="m-b-5 m-t-5">
	  <div class="btn-group">
	  {% if readmore %}
	  <!--More-->
      <a class="btn btn-mini" href="{{ product.url }}">
        <span class="icon-circle-arrow-right icon-arrow-right-2"></span>
		{% if btns == 1 %}{{ '_' | jtext: 'JGLOBAL_DESCRIPTION' }}{% endif %}
      </a>
	  {% endif %}
	  {% if to_cart %}
	  <!--Add to cart-->
	  {% if product.cart_disabled %}
	  <span class="btn btn-mini btn-primary disabled" title="{{ product.cart_title }}">
		<span class="icon-shopping-cart icon-cart icon-white"></span>
		{% if btns == 1 %}{{ '_' | jtext: 'COM_JKASSA_TO_CART' }}{% endif %}
	  </span>
	  {% else %}
	  <a href="#" data-click="to-cart" data-id="{{ product.id }}" data-json="{{ mod_id }}" class="btn btn-mini btn-primary" title="{{ product.cart_title }}">
		<span class="icon-shopping-cart icon-cart icon-white"></span>
		{% if btns == 1 %}{{ '_' | jtext: 'COM_JKASSA_TO_CART' }}{% endif %}
	  </a>
	  {% endif %}
	  {% endif %}
	  {% if to_wishlist %}
	  <!--Add to Wish List-->
	  {% if product.wishlist_disabled %}
	  <span class="btn btn-mini btn-danger disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_ALREADY_WISHLIST', product.name }}">
		<span class="icon-heart icon-white"></span>
		{% if btns == 1 %}{{ '_' | jtext: 'COM_JKASSA_TO_WISHLIST' }}{% endif %}
	  </span>
	  {% else %}
	  <a href="#" data-click="to-wishlist" data-id="{{ product.id }}" data-json="{{ mod_id }}" class="btn btn-mini btn-danger" title="{{ 'sprintf' | jtext: 'COM_JKASSA_TO_WISHLIST_TITLE', product.name }}">
		<span class="icon-heart icon-white"></span>
		{% if btns == 1 %}{{ '_' | jtext: 'COM_JKASSA_TO_WISHLIST' }}{% endif %}
	  </a>
	  {% endif %}
	  {% endif %}
	  {% if to_compare %}
	  <!--Add to compare-->
	  {% if product.compare_disabled %}
	  <span class="btn btn-mini disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ALREADY_ADDED', product.name }}">
		<span class="icon-shuffle icon-random"></span>
		{% if btns == 1 %}{{ '_' | jtext: 'COM_JKASSA_COMPARE_ADD' }}{% endif %}
	  </span>
	  {% else %}
	  <a href="#" data-click="to-compare" data-id="{{ product.id }}" data-json="{{ mod_id }}" class="btn btn-mini" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ADD_TITLE', product.name}}">
		<span class="icon-shuffle icon-random"></span>
		{% if btns == 1 %}{{ '_' | jtext: 'COM_JKASSA_COMPARE_ADD' }}{% endif %}
	  </a>
	  {% endif %}
	  {% endif %}
	  </div>
    </div>
    {% endif %}
  </li>
  {% endfor %}
</ul>