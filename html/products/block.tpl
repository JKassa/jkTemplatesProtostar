<div class="row-fluid block-products">
  <ul class="thumbnails unstyled">
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
                {% assign options = 'decimals' | arrayCombine: 0 %}
                {% if product.discount_image %}
                <img {{ product.discount_image | img_exists: '30x30' }} alt="" title="{{ product.discount_desc }} - {{ product.discount | costDisplay: options }}{{ product.d_symbol }}">
                {% else %}
                <span class="product-label" title="{{ product.discount_desc }} - {{ product.discount | costDisplay: options }}{{ product.d_symbol }}">
                  -{{ product.discount | costDisplay: options }}{% if product.d_symbol == '%' %}{{ product.d_symbol }}{% endif %}
                </span>
                {% endif %}
              </li>
              {% endif %}
            </ul>
            {% endif %}
            
            {% if product.manufacturer %}
            <!--Manufacturer name and miniature-->
            <div style="position: absolute; right: 0; top: 0">
              <img {{ product.manufacturer.thumbnail | img_exists: '30x30' }} class="manufacturer hasTooltip" alt="{{ product.manufacturer.alias }}" title="{{ product.manufacturer.name }}">
            </div>
            {% endif %}
            
            {% if product.tags %}
            <!-- Tags -->
            <div style="position: absolute; right: 0; bottom: 4px">
              {% for tag in product.tags %}
              <a href="{{ tag.url }}" class="{{ tag.link_class }}" style="float: right; border-radius: 9px 0 0 9px; margin-top: 2px">
                {{ tag.title }}
              </a><br>
              {% endfor %}
            </div>
            {% endif %}
            
            <!--Product Image-->
            <div class="center">
			  {% assign jkmedialist = product.image | jkmedialist: product.images, '', img_style, product.url %}
              {% if jkmedialist %}
	            {{ jkmedialist }}
              {% else %}
              <a href="{{ product.url }}" target="_top">
                <img {{ product.image | img_exists: '104x150' }} alt="{{ product.alias }}" style="{{ img_style }}" />
              </a>
			  {% endif %}
            </div>
            
			{% if show_view %}
            <!--Quick view-->
            {% capture selector_quick_view %}jk-quick_view-{{ product.id }}{% endcapture %}
            {{ 'bootstrap.modal' | jhtml: selector_quick_view }}
            <div class="quick-view">
              <a href="#{{ selector_quick_view }}" data-toggle="modal" class="btn jk-quick_view" title="{{ 'sprintf' | jtext: 'COM_JKASSA_QUICK_VIEW_TITLE',  product.name }}">
                <span class="icon-zoom-in"></span>
                {{ '_' | jtext: 'COM_JKASSA_QUICK_VIEW' }}
              </a>
            </div>
			{% endif %}
            
            {% if product.present %}
            <!--Share (Product as a present)-->
            <div class="share hasTooltip" title="{{ 'tooltipText' | jhtml: product.present.name, product.present.desc }}">
              <div class="sharetitle">
                {{ '_' | jtext: 'COM_JKASSA_GIFT' }}
              </div>
              <div class="sharedesc">
                <a href="{{ product.present.url }}" target="_top">
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
              <del>{{ product.old_cost | costDisplay }}{{ currency.symbol }}</del>
              {% endif %}
              <!--cost-->
              <span class="cost">
                <span>{{ product.cost | costDisplay }}</span>{{ currency.symbol }}
              </span>
			  {% if product.vat %}
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
            
            {% comment %}
                Variants product.
                See: html\forms\variants.tpl
            {% endcomment %}
            {% if product.variants %}
            <div>
              {{ product.variants }}
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
            <div class="btn-group m-t-10" style="width: 100%;">
              <!--More-->
              <a href="{{ product.url }}" class="btn btn-small" title="{{ 'sprintf' | jtext: 'COM_JKASSA_READ_MORE', product.name }}" target="_top">
                <span class="icon-circle-arrow-right icon-arrow-right-2"></span>
              </a>
              <!--Add to cart-->
              {% if product.cart_disabled %}
              <span class="btn btn-small btn-primary disabled" title="{{ product.cart_title }}">
                <span class="icon-shopping-cart icon-cart icon-white"></span>
              </span>
              {% else %}
              <a href="#" data-click="to-cart" data-id="{{ product.id }}" class="btn btn-small btn-primary" title="{{ product.cart_title }}">
                <span class="icon-shopping-cart icon-cart icon-white"></span>
              </a>
              {% endif %}
              <!--Add to Wish List-->
              {% if product.wishlist_disabled %}
              <span class="btn btn-small btn-danger disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_ALREADY_WISHLIST', product.name }}">
                <span class="icon-heart icon-white"></span>
              </span>
              {% else %}
              <a href="#" data-click="to-wishlist" data-id="{{ product.id }}" class="btn btn-small btn-danger" title="{{ 'sprintf' | jtext: 'COM_JKASSA_TO_WISHLIST_TITLE', product.name }}">
                <span class="icon-heart icon-white"></span>
              </a>
              {% endif %}
              <!--Add to compare-->
              {% if product.compare_disabled %}
              <span class="btn btn-small disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ALREADY_ADDED', product.name }}">
                <span class="icon-shuffle icon-random"></span>
              </span>
              {% else %}
              <a href="#" data-click="to-compare" data-id="{{ product.id }}" class="btn btn-small" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ADD_TITLE', product.name}}">
                <span class="icon-shuffle icon-random"></span>
              </a>
              {% endif %}
              
              {% comment %}
                  Connecting comments plugin.
                  See: Plugin Manager: Plugins -> jkcomments.
              {% endcomment %}
              {% capture title_comments %}<span class="icon-comments icon-comment"></span> [COUNT]{% endcapture %}
              {% assign count_comments = product.id | jkcountercomments: title_comments, product.url, 'btn btn-small btn-inverse' %}
              
              {% if count_comments %}
              {{ count_comments }}
              {% endif %}
            </div>
          </div>
        </div>
      </div>
      
      {% comment %}
        Madal body for Quick view.
      {% endcomment %}
	  {% if show_view %}
      <script type="text/javascript">
		jQuery(document).ready(function($) {
			$('#{{ selector_quick_view }}').on('show.bs.modal', function() {
				$('body').addClass('modal-open');
				var modalBody = $(this).find('.modal-body');
				modalBody.find('iframe').remove();
				modalBody.prepend('<iframe class="iframe" src="{{ product.quick_url }}" name="{{ product.alias }}" height="400px"></iframe>');
			}).on('shown.bs.modal', function() {
				var modalHeight = $('div.modal:visible').outerHeight(true),
				modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
				modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
				modalBodyHeight = $('div.modal-body:visible').height(),
				modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
				padding = document.getElementById('{{ selector_quick_view }}').offsetTop,
				maxModalHeight = ($(window).height()-(padding*2)),
				modalBodyPadding = (modalBodyHeightOuter-modalBodyHeight),
				maxModalBodyHeight = maxModalHeight-(modalHeaderHeight+modalFooterHeight+modalBodyPadding);
				var iframeHeight = $('.iframe').height();
				if (iframeHeight > maxModalBodyHeight){;
					$('.modal-body').css({'max-height': maxModalBodyHeight, 'overflow-y': 'auto'});
					$('.iframe').css('max-height', maxModalBodyHeight-modalBodyPadding);
				}
			}).on('hide.bs.modal', function () {
				$('body').removeClass('modal-open');
				$('.modal-body').css({'max-height': 'initial', 'overflow-y': 'initial'});
				$('.modalTooltip').tooltip('destroy');
			});
		});
	  </script>
      <div id="{{ selector_quick_view }}" tabindex="-1" class="modal hide fade">
        <div class="modal-header">
          <button type="button" class="close novalidate" data-dismiss="modal">×</button>
          <h3>{{ product.name }}</h3>
        </div>
        <div class="modal-body"></div>
      </div>
	  {% endif %}
    </li>
    {% endfor %}
    
    {% if moreProducts %}
	<!--More products-->
    <li class="span{{ span }}">
      <div class="over-wraper">
        <div class="thumbnail over-wraper-long crossblock">
          <a href="#" data-click="more-products" data-more="{{ moreProducts }}" data-limit="{{ selectedLimit }}">
            <div class="cross">
              <span>&#10227;</span>
            </div>
            <div class="caption text-center">
              <h4>{{ 'plural' | jtext: 'COM_JKASSA_MORE_PRODUCTS', moreProducts }}</h4>
            </div>
          </a>
        </div>
      </div>
    </li>
    {% endif %}
  </ul>
</div>