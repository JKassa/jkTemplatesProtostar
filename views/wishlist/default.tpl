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
<div class="block-products">
  <ul class="row-fluid thumbnails">
    {% for product in products %}
    <li class="span{{ span }}">
      <div class="over-wraper">
        <div class="thumbnail over-wraper-long">
          <div class="product-image">
            {% if product.stickers %}
            <!-- Stickers -->
            <ul class="stickers">
              {% if product.new %}
              <li>
                <span class="product-label product-label_new">NEW</span>
              </li>
              {% endif %}
              {% if product.hit %}
              <li>
                <span class="product-label product-label_hit">HIT</span>
              </li>
              {% endif %}
              {% if product.discount %}
              <li>
                {% if product.discount_image %}
                <img {{ product.discount_image | img_exists: '30x30' }} alt="{{ product.discount }}" title="{{ product.discount_desc }} - {{ product.discount }}">
                {% else %}
                <span class="product-label" title="{{ product.discount_desc }} - {{ product.discount }}">-{{ product.discount }}</span>
                {% endif %}
              </li>
              {% endif %}
            </ul>
            {% endif %}
            
            {% if product.manufacturer %}
            <!--Manufacturer name and miniature-->
            <div style="position: absolute; right:0; top:0;" itemtype="http://schema.org/Brand" itemscope itemprop="brand">
              <span style="display: none;" itemprop="name">{{ product.manufacturer.name }}</span>
              <img {{ product.manufacturer.thumbnail | img_exists: '30x30' }} class="manufacturer hasTooltip" itemprop="logo" alt="{{ product.manufacturer.alias }}" title="{{ product.manufacturer.name }}">
            </div>
            {% endif %}
            
            <!--Product Image-->
            <div class="center">
              <a href="{{ product.url }}" target="_top">
                <img {{ product.image | img_exists: '104x150' }} alt="{{ product.alias }}" style="max-width: 100%; max-height: {{ img_height }}px;" />
              </a>
            </div>
            
            {% if product.present %}
            <!--Share (Product as a present)-->
            <div class="share hasTooltip" title="{{ 'tooltipText' | jhtml: product.present.name, product.present.desc }}">
              <div class="sharetitle">
                {{ '_' | jtext: 'COM_JKASSA_GIFT' }}
              </div>
              <div class="sharedesc">
                <a href="{{ product.present.url }}">
                  <img {{ product.present.image | img_exists: '50x50' }} alt="{{ product.present.name }}">
                </a>
              </div>
            </div>
            {% endif %}
          </div>
          <div class="caption">
            <!--Name and URL of the product-->
            <h4>
              <a href="{{ product.url }}" target="_top">
                {{ product.name }}
              </a>
              {% if product.files %}
              <!--Files-->
              <span title="<strong>{{ '_' | jtext: 'COM_JKASSA_ATTACHMENT' }}:</strong><br>{{ product.files | join: '<br>' }}" class="hasTooltip">
                <span class="icon-flag-2 icon-download small"></span>
              </span>
              {% endif %}
            </h4>
            
            <!--Price product-->
            <div class="m-t-10">
              {% if product.old_cost %}
              <!--old cost-->
              <del>{{ product.old_cost }}</del>
              {% endif %}
              <!--cost-->
              <span class="cost">
                <meta itemprop="priceCurrency" content="{{ currency.code }}" />
                {% assign options = 'dec_point,thousands_sep' | arrayCombine: '.', '*' %}
                <span itemprop="price" content="{{ product.cost | costDisplay: options }}">{{ product.cost | costDisplay }}</span>{{ currency.symbol }}
              </span>
			  {% if product.vat %}
		      <!--vat-->
	  	      <span class="muted small">
		        ({{ 'sprintf' | jtext: 'COM_JKASSA_VAT_INCL', product.vat }})
	 	      </span>
      	      {% endif %}
            </div>
            
			{% if show_stock %}
            <!--Stock-->
            <div class="muted m-t-5 text-right">
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
            
            {% comment %}
                Connecting voting plugin.
                See: Plugin Manager: Plugins -> jkvotes.
            {% endcomment %}
            {% assign votes = product.id | jkcountervotes: product.rating, product.rating_count %}
            {% if votes %}
            <!--Rating-->
            <div class="text-right">
              {{ votes }}
            </div>
            {% endif %}
            
            {% if product.variants %}
            <!--Variants product-->
            <div class="m-t-10" id="variant-{{ product.index }}">
              {% for variant in product.variants %}
                {{ variant.name }}:
                {% case variant.type %}
                  {% when 'radio' %}
                    <span class="variant-radio-value">
                      {{ variant.value }}
                    </span>
                  {% when 'color' %}
                    <span class="minicolors-swatch">
                      <span style="background-color: {{ variant.value }}" title="{{ variant.title }}"></span>
                    </span>
                  {% when 'select' %}
                    <span>
                      {{ variant.value }}
                    </span>
                {% endcase %}
                <input type="hidden" data-attr-title="{{ variant.title }}" name="variant-{{ product.id }}-{{ variant.id }}" value="{{ variant.value }}">
                <br>
              {% endfor %}
            </div>
            {% endif %}
			
			{% if product.cart_disabled != 'false' and show_quantity %}
            <!--Quantity-->
            <div class="input-prepend input-append qty-product m-t-10 m-b-0">
              <a href="javascript:;" data-click="qty-minus" data-id="{{ product.id }}" class="btn" title="{{ '_' | jtext: 'COM_JKASSA_QTY_BTN' }}">&minus;</a>
              <input type="text" value="{{ product.limit }}" data-limit="{{ product.limit }}" data-maxlimit="{{ product.maxlimit }}" class="span3" name="qty-product-{{ product.id }}" title="{{ '_' | jtext: 'COM_JKASSA_QTY_TITLE' }}">
              <a href="javascript:;" data-click="qty-plus" data-id="{{ product.id }}" class="btn" title="{{ '_' | jtext: 'COM_JKASSA_QTY_BTN' }}">+</a>
            </div>
            {% endif %}
            
            <!--Buttons-->
            <div class="btn-group m-t-10" style="width: 100%">
              <!--More-->
              <a href="{{ product.url }}" class="btn btn-small" title="{{ 'sprintf' | jtext: 'COM_JKASSA_READ_MORE', product.name }}" itemprop="url" target="_top">
                <span class="icon-circle-arrow-right icon-arrow-right-2"></span>
              </a>
              <!--Add to cart-->
              {% if product.cart_disabled %}
                {% if product.stock == 0 %}
                  {% assign cart_btn_title = '_' | jtext: 'COM_JKASSA_STOCK_0' %}
                {% else %}
                  {% assign cart_btn_title = 'sprintf' | jtext: 'COM_JKASSA_ALREADY_CART', product.name %}
                {% endif %}
              <span class="btn btn-small btn-primary disabled" title="{{ cart_btn_title }}">
                <span class="icon-shopping-cart icon-cart"></span>
              </span>
              {% else %}
              <a href="#" data-click="to-cart-user" data-index="{{ product.index }}" data-id="{{ product.id }}" class="btn btn-primary btn-small" title="{{ 'sprintf' | jtext: 'COM_JKASSA_TO_CART_TITLE', product.name }}">
                <span class="icon-shopping-cart icon-cart"></span>
              </a>
              {% endif %}
              <!--Add to compare-->
              {% if product.compare_disabled %}
              <span class="btn btn-small disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ALREADY_ADDED', product.name }}">
                <span class="icon-shuffle icon-random"></span>
              </span>
              {% else %}
              <a href="#" data-click="to-compare-user" data-index="{{ product.index }}" data-id="{{ product.id }}" class="btn btn-small" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ADD_TITLE', product.name}}">
                <span class="icon-shuffle icon-random"></span>
              </a>
              {% endif %}
              <!--Remove from wishlist-->
              <a href="#" data-click="remove-wishlist" data-index="{{ product.index }}" class="btn btn-small btn-danger" title="{{ '_' | jtext: 'COM_JKASSA_ACCOUNT_WISHLIST_REMOVE' }}">
                <span class="icon-remove icon-white"></span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </li>
    {% endfor %}
  </ul>
</div>
<div class="text-center m-b-20">
	<!--Remove from wishlist (all)-->
	<a href="#" class="btn btn-danger" data-click="remove-wishlist-all">
		<span class="icon-trash icon-white"></span>
		{{ '_' | jtext: 'COM_JKASSA_CLEAR_ALL' }}
	</a>
</div>
{% else %}
<div class="alert alert-block">
  {{ '_' | jtext: 'COM_JKASSA_ACCOUNT_WISHLIST_EMPTY' }}
</div>
{% endif %}

{% if viewtmpl != 'component' and posttext %}
<!--Posttext-->
<div>
  {{ posttext }}
</div>
{% endif %}