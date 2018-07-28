{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}
{{ 'bootstrap.tooltip' | jhtml }}
{% assign options = 'disable_search_threshold' | arrayCombine: 20 %}
{{ 'formbehavior.chosen' | jhtml: 'select', null, options }}

{% comment %}
	Parameters of the product.
{% endcomment %}
{% assign show_sku = tpl_params.sku | default_value: 1 %}
{% assign show_stock = tpl_params.stock | default_value: 1 %}
{% assign show_quantity = tpl_params.quantity | default_value: 1 %}
{% assign show_info = tpl_params.info | default_value: 1 %}
{% assign show_icons = tpl_params.icons | default_value: 1 %}
{% assign show_nav = tpl_params.nav | default_value: 1 %}

{% comment %}
	Variable depending on the availability of the product:
    '0'  - Not in stock;
    '-1' - In stock;
    '-2' - To order;
    'X'  - Balance of stock.
{% endcomment %}
{% case stock %}
	{% when 0 %}
		{% assign stock_icon = '<span class="icon-checkbox icon-check icon-danger"></span>' %}
        {% assign stock_text = '_' | jtext: 'COM_JKASSA_STOCK_0' %}
        {% assign btn_buyDisabled = false %}
        {% assign btn_buy = false %}
        {% assign btn_cartDisabled = false %}
        {% assign btn_cart = false %}
        {% assign btn_report = true %}
        {% assign btn_quickorder = false %}
	{% when '-1' %}
		{% assign stock_icon = '<span class="icon-checkbox icon-check icon-success"></span>' %}
        {% assign stock_text = '_' | jtext: 'COM_JKASSA_STOCK_1' %}
        {% assign btn_buyDisabled = false %}
        {% assign btn_buy = true %}
        {% assign btn_cartDisabled = false %}
        {% assign btn_cart = true %}
        {% assign btn_report = false %}
        {% assign btn_quickorder = true %}
	{% when '-2' %}
		{% assign stock_icon = '<span class="icon-checkbox icon-check"></span>' %}
        {% assign stock_text = '_' | jtext: 'COM_JKASSA_STOCK_2' %}
        {% assign btn_buyDisabled = false %}
        {% assign btn_buy = false %}
        {% assign btn_cartDisabled = false %}
        {% assign btn_cart = false %}
        {% assign btn_report = false %}
        {% assign btn_quickorder = true %}
	{% else %}
		{% assign stock_icon = '<span class="icon-checkbox icon-check icon-success"></span>' %}
        {% assign stock_text = 'sprintf' | jtext: 'COM_JKASSA_STOCK_N', stock %}
        {% assign btn_buyDisabled = false %}
        {% assign btn_buy = true %}
        {% assign btn_cartDisabled = false %}
        {% assign btn_cart = true %}
        {% assign btn_report = false %}
        {% assign btn_quickorder = true %}
{% endcase %}

{% comment %}
	In cart.
{% endcomment %}
{% if cart_disabled %}
	{% assign btn_cartDisabled = true %}
    {% assign btn_cart = false %}
{% endif %}

{% if heading and quickview == 0 %}
<!--Heading-->
<div class="page-header">
  <h1>{{ heading }}</h1>
</div>
{% endif %}

<!--Product-->
<div class="row-fluid" itemscope itemtype="http://schema.org/Product">
  <!--Images-->
  <div class="span7 product-image">
	{% assign jkmedia = images | jkmedia: 64, 380 %}
    {% if jkmedia %}
      {{ jkmedia }}
    {% else %}
    <img {{ image | img_exists: '260x380' }} alt="{{ alias }}">
    {% endif %}
    
    {% if stickers %}
    <!-- Stickers -->
    <ul class="stickers">
      {% if new %}
      <li>
        <span class="product-label product-label_new">NEW</span>
      </li>
      {% endif %}
      {% if hit %}
      <li>
        <span class="product-label product-label_hit">HIT</span>
      </li>
      {% endif %}
      {% if discount %}
      <li>
        {% assign options = 'decimals' | arrayCombine: 0 %}
        {% if discount_image %}
        <img {{ discount_image | img_exists: '30x30' }} alt="" title="{{ discount_desc }} - {{ discount | costDisplay: options }}{{ d_symbol }}">
        {% else %}
        <span class="product-label" title="{{ discount_desc }} - {{ discount | costDisplay: options }}{{ d_symbol }}">
          -{{ discount | costDisplay: options }}{% if d_symbol == '%' %}{{ d_symbol }}{% endif %}
        </span>
        {% endif %}
      </li>
      {% endif %}
    </ul>
    {% endif %}
    
    {% if tags %}
    <!-- Tags -->
    <div style="position: absolute; right: 0; top: 4px">
      {% for tag in tags %}
      <a href="{{ tag.url }}" class="{{ tag.link_class }}" style="float: right; border-radius: 9px 0 0 9px; margin-top: 2px">
        {{ tag.title }}
      </a><br>
      {% endfor %}
    </div>
    {% endif %}
  </div>
  
  <!--Cost block-->
  <div class="span5">
    {% if manufacturer %}
    <!--Manufacturer-->
    <div itemtype="http://schema.org/Brand" itemscope itemprop="brand">
      <a title="{{ manufacturer.name }}" href="{{ manufacturer.url }}" target="_top">
		<span style="display: none;" itemprop="name">{{ manufacturer.name }}</span>
        <img src="{{ manufacturer.logo }}" alt="{{ manufacturer.alias }}" class="img-polaroid" style="max-height: 60px; max-width: 200px" itemprop="logo">
      </a>
    </div>
    {% endif %}
    
    {% comment %}
	    Rating reviews JKassa or Plug-in voting (See: Plugin Manager: Plugins -> jkvotes).
    {% endcomment %}
	{% if reviews_included %}
	  <!--Rating reviews-->
	  <div id="jkReviewsRating" class="m-t-10" style="display: inline-block;">
	    {% include 'html/reviews/rating' %}
	  </div>
	{% else %}
      {% assign votes = id | jkvotes: rating, rating_count %}
      {% if votes %}
        <!--Voting-->
        <div class="m-t-10">
          {{ votes }}
        </div>
      {% endif %}
	{% endif %}
    
    <!--Name-->
    <h2>
      <a itemprop="url" href="{{ url }}" target="_top">
        <span itemprop="name">
          {{ name }}
        </span>
      </a>
      
      {% if files %}
      <!--Files-->
      <span class="hasTooltip" title="<strong>{{ '_' | jtext: 'COM_JKASSA_ATTACHMENT' }}:</strong><br>{{ files | join: '<br>' }}">
        <span class="icon-flag-2 icon-download small"></span>
      </span>
      {% endif %}
    </h2>
    
    {% if present %}
    <!--Share (Product as a present)-->
    <div class="share">
      <div class="sharetitle">
        + {{ present.name }}
      </div>
      <div class="sharedesc">
        <a href="{{ present.url }}" target="_top">
          <img {{ present.image | img_exists: '50x50' }} alt="{{ present.name }}">
          <span>{{ present.desc }}</span>
        </a>
      </div>
    </div>
    {% endif %}
    
    <!--Cost-->
    <div itemscope itemprop="offers" itemtype="http://schema.org/Offer">
      <meta content="{{ currency.code }}" itemprop="priceCurrency">
      <link href="http://schema.org/InStock" itemprop="availability">
      {% if old_cost %}
      <del>{{ old_cost | costDisplay }}{{ currency.symbol }}</del>
      {% endif %}
	  {% assign options = 'dec_point,thousands_sep' | arrayCombine: '.', '*' %}
      <span class="lead" itemprop="price" content="{{ cost | costDisplay: options }}">{{ cost | costDisplay }}</span><strong>{{ currency.symbol }}</strong>
	  {% if vat %}
	  <span class="muted small">
		({{ 'sprintf' | jtext: 'COM_JKASSA_VAT_INCL', vat }})
	  </span>
      {% endif %}
    </div>
    
	{% if show_sku %}
    <!--SKU (code)-->
    <div class="muted small text-right">
      {{ '_' | jtext: 'COM_JKASSA_SKU' }}:
      <span itemprop="mpn">
        {{ sku }}
      </span>
    </div>
	{% endif %}
    
    {% comment %}
        Variants product.
        See: html\forms\variants.tpl
    {% endcomment %}
    {% if variants %}
    <div>
      {{ variants }}
    </div>
    {% endif %}
    
	{% if show_stock %}
    <!--Stock-->
    <div class="muted small m-t-10">
      {{ stock_icon }} {{ stock_text }}
    </div>
	{% endif %}
	
	{% if cart_disabled != 'false' and show_quantity %}
	<!--Quantity-->
	<div class="input-prepend input-append qty-product m-t-10 m-b-0">
	  <a href="javascript:;" data-click="qty-minus" data-id="{{ id }}" class="btn" title="{{ '_' | jtext: 'COM_JKASSA_QTY_BTN' }}">&minus;</a>
	  <input type="text" value="{{ limit }}" data-limit="{{ limit }}" data-maxlimit="{{ maxlimit }}" class="span3" name="qty-product-{{ id }}" title="{{ '_' | jtext: 'COM_JKASSA_QTY_TITLE' }}">
	  <a href="javascript:;" data-click="qty-plus" data-id="{{ id }}" class="btn" title="{{ '_' | jtext: 'COM_JKASSA_QTY_BTN' }}">+</a>
	</div>
	{% endif %}
    
    <!--Buttons-->
    <div class="m-t-10">
      {% if btn_buyDisabled %}
      <!--Buy disabled-->
      <span class="btn btn-primary disabled">
        <span class="icon-ok icon-white"></span>
        {{ '_' | jtext: 'COM_JKASSA_BUY' }}
      </span>
      {% endif %}
      
      {% if btn_buy %}
      <!--Buy-->
      <a href="#" data-click="to-order" data-id="{{ id }}" data-url="{{ form_url }}" class="btn btn-success">
        <span class="icon-ok icon-white"></span>
        {{ '_' | jtext: 'COM_JKASSA_BUY' }}
      </a>
      {% endif %}
      
      {% if btn_cartDisabled %}
      <!--Cart disabled-->
      <span class="btn btn-info disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_ALREADY_CART', name }}">
        <span class="icon-shopping-cart icon-cart icon-white"></span>
        {{ '_' | jtext: 'COM_JKASSA_IN_CART' }}
      </span>
      {% endif %}
      
      {% if btn_cart %}
      <!--Cart-->
      <a href="#" data-click="to-cart" data-id="{{ id }}" class="btn btn-info" title="{{ 'sprintf' | jtext: 'COM_JKASSA_TO_CART_TITLE', name }}">
        <span class="icon-shopping-cart icon-cart icon-white"></span>
        {{ '_' | jtext: 'COM_JKASSA_TO_CART' }}
      </a>
      {% endif %}
      
      {% if btn_report %}
      <!--Waiting List-->
      {{ 'bootstrap.modal' | jhtml: 'jk-modal_waitinglist' }}
      <a href="#jk-modal_waitinglist" data-toggle="modal" class="btn">
        <span class="icon-mail-2 icon-envelope"></span>
        {{ '_' | jtext: 'COM_JKASSA_WAITINGLIST' }}
      </a>
      {% endif %}
      
      <!--Add to Wishlist-->
      {% if wishlist_disabled %}
      <span class="btn btn-circle disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_ALREADY_WISHLIST', name }}">
        <span class="icon-heart icon-danger"></span>
      </span>
      {% else %}
      <a href="#" data-click="to-wishlist" data-id="{{ id }}" class="btn btn-circle" title="{{ 'sprintf' | jtext: 'COM_JKASSA_TO_WISHLIST_TITLE', name }}">
        <span class="icon-heart icon-danger"></span>
      </a>
      {% endif %}
      
      <!--Add to compare-->
      {% if compare_disabled %}
      <span class="btn btn-circle disabled" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ALREADY_ADDED', name }}">
        <span class="icon-shuffle icon-random"></span>
      </span>
      {% else %}
      <a href="#" data-click="to-compare" data-id="{{ id }}" class="btn btn-circle" title="{{ 'sprintf' | jtext: 'COM_JKASSA_COMPARE_ADD_TITLE', name}}">
        <span class="icon-shuffle icon-random"></span>
      </a>
      {% endif %}
    </div>
    
    {% if btn_quickorder and quickorder %}
    <!--Quick order-->
    <div class="m-t-10">
      {{ 'bootstrap.modal' | jhtml: 'jk-modal_quickorder' }}
      <a href="#jk-modal_quickorder" data-toggle="modal" class="btn btn-inverse">
        <span class="icon-star icon-white"></span>
        {{ '_' | jtext: 'COM_JKASSA_QUICK_ORDER' }}
      </a>
    </div>
    {% endif %}
    
    {% if f_attributes %}
    <!--Featured attributes-->
    <dl class="dl-horizontal">
      {% for attribute in f_attributes %}
      <dt>{{ attribute.name }}</dt>
      <dd>
        {{ attribute.value }}
        {% if attribute.tooltip %}
        <span class="hasTooltip" title="{{ attribute.tooltip }}">
          <span class="icon-help icon-question-sign"></span>
        </span>
        {% endif %}
      </dd>
      {% endfor %}
    </dl>
    {% endif %}
    
    {% comment %}
        Connecting social plugin.
        See: Plugin Manager: Plugins -> jksocial.
    {% endcomment %}
    {% assign social = id | jksocial: name, image, metadesc, return_url %}
    {% if social %}
    <div class="m-t-10">
      {{ social }}
    </div>
    {% endif %}
	
	{% if aff_income %}
    <!--Affiliate Links-->
    <div class="m-t-10">
      {{ 'bootstrap.modal' | jhtml: 'jk-modal_affiliate' }}
      <a href="#jk-modal_affiliate" data-toggle="modal" class="muted">
        <span class="icon-flag"></span>
		  <em>{{ '_' | jtext: 'COM_JKASSA_AFFILIATE_AFFILIATE_REWARD' }}: <strong>{{ aff_income | costDisplay }}{{ currency.symbol }}</strong></em>
      </a>
    </div>
    {% endif %}
  </div>
  
  <!--Product Description (introtext)-->
  <span itemprop="description" style="display: none">
    {{ introtext | truncateDesc: 140 }}
  </span>
</div>

{% comment %}
    Connecting comments plugin (position: tabbed).
    See: Plugin Manager: Plugins -> jkcomments.
{% endcomment %}
{% assign com_tabbed = id | jkcomments: name, 'tabbed' %}

<!--Tabs-->
<div class="m-t-10">
  <ul class="nav nav-tabs" id="prodTab">
    <li class="active">
      <a href="#description">{{ '_' | jtext: 'JGLOBAL_DESCRIPTION' }}</a>
    </li>
    {% if attributes %}
    <li>
      <a href="#attributes">{{ '_' | jtext: 'COM_JKASSA_ATTRIBUTES' }}</a>
    </li>
    {% endif %}
    {% if tabs %}
    {% for tab in tabs %}
    <li>
      <a href="#{{ tab.id }}">{{ tab.name }}</a>
    </li>
    {% endfor %}
    {% endif %}
	{% if reviews_included %}
	<li>
      <a href="#reviews">{{ '_' | jtext: 'COM_JKASSA_REVIEWS' }} ({{ rating_count }})</a>
    </li>
	{% endif %}
    {% if com_tabbed %}
    <li>
      <a href="#comments">{{ '_' | jtext: 'COM_JKASSA_COMMENTS' }}</a>
    </li>
    {% endif %}
  </ul>
  <div class="tab-content">
    <!--Description-->
    <div class="tab-pane active" id="description">
      {{ fulltext }}
    </div>
    
    {% if attributes %}
    <!--Attributes-->
    <div class="tab-pane" id="attributes">
      <dl class="dl-horizontal">
        {% for attribute in attributes %}
        <dt>{{ attribute.name }}</dt>
        <dd>
          {{ attribute.value }}
          {% if attribute.tooltip %}
          <span class="hasTooltip" title="{{ attribute.tooltip }}">
            <span class="icon-help icon-question-sign"></span>
          </span>
          {% endif %}
        </dd>
        {% endfor %}
      </dl>
    </div>
    {% endif %}
    
    {% if tabs %}
    {% for tab in tabs %}
    <div class="tab-pane" id="{{ tab.id }}">
      {{ tab.content }}
    </div>
    {% endfor %}
    {% endif %}
	  
	{% if reviews_included %}
	<!--Reviews-->
	<div class="tab-pane" id="reviews">
	  {% include 'html/reviews/reviews' %}
	</div>
	{% endif %}
    
    {% if com_tabbed %}
    <!--Comments-->
    <div class="tab-pane" id="comments">
      {{ com_tabbed }}
    </div>
    {% endif %}
  </div>
  <script type="text/javascript">
	jQuery('#prodTab a').click(function (e) {
      e.preventDefault();
      jQuery(this).tab('show');
    })
  </script>
</div>

{% if cheaper %}
<!--Share: Together cheaper-->
<div class="m-t-30">
  <h3>{{ '_' | jtext: 'COM_JKASSA_CART_TOGETHER_CHEAPER' }}</h3>
  {% include 'html/products/cheaper' %}
</div>
{% endif %}

{% comment %}
    Connecting comments plugin (position: bottom).
    See: Plugin Manager: Plugins -> jkcomments.
{% endcomment %}
{% assign com_bottom = id | jkcomments: name, 'bottom' %}
{% if com_bottom %}
  {{ com_bottom }}
{% endif %}

{% if quickview == 0 %}
<div class="row-fluid">
	{% if show_icons %}
	{% if print_screen == 0 %}
	<!--Print / Email / Edit-->
	<div class="btn-group pull-right m-t-5 m-r-5">
		<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
			<span class="icon-cog"></span>
			<span class="caret">&nbsp;</span>
		</a>
		<ul class="dropdown-menu actions">
			<li>{{ print_icon }}</li>
			<li>{{ email_icon }}</li>
			{% if edit_icon %}
			<li class="divider"></li>
			<li>{{ edit_icon }}</li>
			{% endif %}
		</ul>
	</div>
	<!--Print-->
	{% else %}
	<div class="btn no-print" style="position: fixed; right: 10px; top: 10px">
		{{ print_screen }}
	</div>
	{% endif %}
	{% endif %}
	
	{% if show_info %}
	<!--Details-->
	<ul class="breadcrumb m-t-0">
		<li>
			<span class="icon-user"></span>
			{{ 'sprintf' | jtext: 'COM_JKASSA_WRITTEN_BY', '' }}
			{% if contact_link %}
			<a href="{{ contact_link }}">{{ author }}</a>
			{% else %}
			{{ author }}
			{% endif %}
			<span class="divider">|</span>
		</li>
		{% if parent_title %}
		<li>
			<span class="icon-folder-close"></span>
			{% capture parent %}<a href="{{ parent_url }}">{{ parent_title }}</a>{% endcapture %}
			{{ 'sprintf' | jtext: 'COM_JKASSA_PARENT', parent }}
			<span class="divider">|</span>
		</li>
		{% endif %}
		<li>
			<span class="icon-folder-open"></span>
			{% capture category %}<a href="{{ category_url }}">{{ category_title }}</a>{% endcapture %}
			{{ 'sprintf' | jtext: 'COM_JKASSA_CATEGORY', category }}
			<span class="divider">|</span>
		</li>
		<li>
			<span class="icon-calendar"></span>
			<time datetime="{{ 'date' | jhtml: publish, 'c' }}">
				{% assign date_publish = 'date' | jhtml: publish, 'DATE_FORMAT_LC2' %}
				{{ 'sprintf' | jtext: 'COM_JKASSA_PUBLISHED_DATE_ON', date_publish }}
			</time>
			<span class="divider">|</span>
		</li>
		<li>
			<span class="icon-calendar"></span>
			<time datetime="{{ 'date' | jhtml: created, 'c' }}">
				{% assign date_created = 'date' | jhtml: created, 'DATE_FORMAT_LC2' %}
				{{ 'sprintf' | jtext: 'COM_JKASSA_CREATED_DATE_ON', date_created }}
			</time>
			<span class="divider">|</span>
		</li>
		<li>
			<span class="icon-calendar"></span>
			<time datetime="{{ 'date' | jhtml: modified, 'c' }}">
				{% assign date_modified = 'date' | jhtml: modified, 'DATE_FORMAT_LC2' %}
				{{ 'sprintf' | jtext: 'COM_JKASSA_LAST_UPDATED', date_modified }}
			</time>
			<span class="divider">|</span>
		</li>
		<li>
			<span class="icon-eye-open"></span>
			{{ 'sprintf' | jtext: 'COM_JKASSA_PRODUCT_HITS', hits }}
		</li>
	</ul>
	{% endif %}
</div>
  
{% if pagination and show_nav %}
<!--Pagination-->
<ul class="pager pagenav">
	{% if pagination.prev %}
	<li class="previous">
		<a href="{{ pagination.prev }}" rel="prev">
			<span class="icon-arrow-left icon-chevron-left"></span> {{ '_' | jtext: 'JPREV' }}
		</a>
	</li>
	{% endif %}
	{% if pagination.next %}
	<li class="next">
		<a href="{{ pagination.next }}" rel="next">
			{{ '_' | jtext: 'JNEXT' }} <span class="icon-arrow-right icon-chevron-right"></span>
		</a>
	</li>
	{% endif %}
</ul>
{% endif %}
{% endif %}

{% comment %}
  Madal body for Waiting List.
{% endcomment %}
<script type="text/javascript">
  jQuery(document).ready(function($) {
	  $('#jk-modal_waitinglist').on('show.bs.modal', function() {
		  $('body').addClass('modal-open');
		  var modalBody = $(this).find('.modal-body');
		  modalBody.find('iframe').remove();
		  modalBody.prepend('<iframe class="iframe" src="{{ waitinglist }}" name="waitinglist" height="400px"></iframe>');
	  }).on('shown.bs.modal', function() {
		  var modalHeight = $('div.modal:visible').outerHeight(true),
		  modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
		  modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
		  modalBodyHeight = $('div.modal-body:visible').height(),
		  modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
		  padding = document.getElementById('jk-modal_waitinglist').offsetTop,
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
<div id="jk-modal_waitinglist" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
	<button type="button" class="close novalidate" data-dismiss="modal">×</button>
	<h3>{{ '_' | jtext: 'COM_JKASSA_WAITINGLIST' }}</h3>
  </div>
  <div class="modal-body"></div>
</div>

{% comment %}
  Madal body for Quick order.
{% endcomment %}
<script type="text/javascript">
  jQuery(document).ready(function($) {
      $('#jk-modal_quickorder').on('show.bs.modal', function() {
          $('body').addClass('modal-open');
          var modalBody = $(this).find('.modal-body');
          modalBody.find('iframe').remove();
          modalBody.prepend('<iframe class="iframe" src="{{ quickorder }}" name="quickorder" height="400px"></iframe>');
      }).on('shown.bs.modal', function() {
          var modalHeight = $('div.modal:visible').outerHeight(true),
          modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
          modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
          modalBodyHeight = $('div.modal-body:visible').height(),
          modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
          padding = document.getElementById('jk-modal_quickorder').offsetTop,
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
<div id="jk-modal_quickorder" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
    <button type="button" class="close novalidate" data-dismiss="modal">×</button>
    <h3>{{ '_' | jtext: 'COM_JKASSA_QUICK_ORDER' }}</h3>
  </div>
  <div class="modal-body"></div>
</div>

{% comment %}
  Madal body for Affiliate Links.
{% endcomment %}
{% if aff_income %}
<script type="text/javascript">
  jQuery(document).ready(function($) {
      $('#jk-modal_affiliate').on('show.bs.modal', function() {
          $('body').addClass('modal-open');
          var modalBody = $(this).find('.modal-body');
          modalBody.find('iframe').remove();
          modalBody.prepend('<iframe class="iframe" src="{{ aff_url }}" name="affiliate" height="200px"></iframe>');
      }).on('shown.bs.modal', function() {
          var modalHeight = $('div.modal:visible').outerHeight(true),
          modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
          modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
          modalBodyHeight = $('div.modal-body:visible').height(),
          modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
          padding = document.getElementById('jk-modal_affiliate').offsetTop,
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
<div id="jk-modal_affiliate" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
    <button type="button" class="close novalidate" data-dismiss="modal">×</button>
    <h3>{{ '_' | jtext: 'COM_JKASSA_AFFILIATE_PROGRAM' }}</h3>
  </div>
  <div class="modal-body"></div>
</div>
{% endif %}