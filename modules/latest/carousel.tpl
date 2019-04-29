{% assign rows		= products | arrayChunk: 4 %}
{% assign active	= 0 %}
{% assign dataslide	= 0 %}

<div class="carousel slide mjkcarousel" id="mjklCarousel_{{ mod_id }}">
  <ol class="carousel-indicators">
    {% for row in rows %}
    <li data-target="#mjklCarousel_{{ mod_id }}" data-slide-to="{{ dataslide }}" class="{% if dataslide == 0 %}active{% endif %}"></li>
    {% assign dataslide = dataslide | plus: 1 %}
    {% endfor %}
  </ol>
  <div class="carousel-inner">
    {% for row in rows %}
    {% assign active = active | plus: 1 %}
    <div class="item {% if active == 1 %}active{% endif %}">
      <ul class="thumbnails">
        {% for product in row %}
        <li class="span3 thumbnail">
          <div style="{{ block_height }}">
            {% if product.image %}
            <div class="product-image">
              <a href="{{ product.url }}" title="{{ product.name }}">
                <img src="{{ product.image }}" alt="{{ product.alias }}" style="{{ img_width_height }}" />
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
              {% if product.cost and product.old_cost %}
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
			{% if show_stock %}
            <!--Stock-->
            <div class="muted m-t-5 text-right small">
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
			  <div class="text-right" title="{{ 'plural' | jtext: 'COM_JKASSA_REVIEWS_COUNT', product.rating_count }}">
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
			  <div class="text-right">
				{{ votes }}
			  </div>
			  {% endif %}
			{% endif %}
			{% endif %}
            {% if btns %}
			<div class="btn-group m-t-5">
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
			{% endif %}
          </div>
        </li>
        {% endfor %}
      </ul>
    </div>
    {% endfor %}
  </div>
  <div class="control-box">
    <a data-slide="prev" href="#mjklCarousel_{{ mod_id }}" class="carousel-control left">&lsaquo;</a>
    <a data-slide="next" href="#mjklCarousel_{{ mod_id }}" class="carousel-control right">&rsaquo;</a>
  </div>
</div>

{{ 'bootstrap.framework' | jhtml }}
<script>
jQuery(document).ready(function ()
{
	jQuery('#mjklCarousel_{{ mod_id }}').carousel({
		interval: {{ interval }},
		string: "hover"
	});
	
	// carousel fix conflict with mootools
	if (typeof jQuery != 'undefined' && typeof MooTools != 'undefined' ) {
		Element.implement({
			slide: function(how, mode){
				return this;
			}
		});
	}
});
</script>