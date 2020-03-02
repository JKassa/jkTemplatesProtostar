{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}
{{ 'bootstrap.tooltip' | jhtml }}
{% assign options = 'disable_search_threshold' | arrayCombine: 20 %}
{{ 'formbehavior.chosen' | jhtml: 'select', null, options }}

<!--Header-->
<div class="page-header">
  {% if heading %}
  <h1>{{ heading }}</h1>
  {% else %}
  <h2>{{ title }}</h2>
  {% endif %}
</div>

{% if pretext %}
<!--Pretext-->
<div>
  {{ pretext }}
</div>
{% endif %}

<!--Profile-->
{{ profile }}

<!--Nav-->
<ul class="nav nav-tabs nav-stacked">
  {% if guest %}
  <li>
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_login' }}
    <a href="#jk-modal_login" data-toggle="modal">
      {{ '_' | jtext: 'JLOGIN' }}
    </a>
  </li>
  {% endif %}
  {% if allow_registration %}
  <li>
    <a href="{{ registration_route }}">
      {{ '_' | jtext: 'JREGISTER' }}
    </a>
  </li>
  {% endif %}
  <li>
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_cart' }}
    <a href="#jk-modal_cart" data-toggle="modal">
      {{ '_' | jtext: 'COM_JKASSA_YOUR_CART' }}
      <span class="badge pull-right">{{ cart_quantity }}</span>
    </a>
  </li>
  <li>
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_viewed' }}
    <a href="#jk-modal_viewed" data-toggle="modal">
      {{ '_' | jtext: 'COM_JKASSA_VIEWED' }}
      <span class="badge pull-right">{{ viewed_quantity }}</span>
    </a>
  </li>
  <li>
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_wishlist' }}
    <a href="#jk-modal_wishlist" data-toggle="modal">
      {{ '_' | jtext: 'COM_JKASSA_YOUR_WISHLIST' }}
      <span class="badge pull-right">{{ wishlist_quantity }}</span>
    </a>
  </li>
  <li>
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_compare' }}
    <a href="#jk-modal_compare" data-toggle="modal">
      {{ '_' | jtext: 'COM_JKASSA_COMPARE_PRODUCTS' }}
      <span class="badge pull-right">{{ compare_quantity }}</span>
    </a>
  </li>
  {% if guest != 1 %}
  <li>
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_orders' }}
    <a href="#jk-modal_orders" data-toggle="modal">
      {{ '_' | jtext: 'COM_JKASSA_YOUR_ORDERS' }}
      <span class="badge pull-right">{{ orders_quantity }}</span>
    </a>
  </li>
  {% endif %}
  {% if guest != 1 %}
  <li>
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_reviews' }}
    <a href="#jk-modal_reviews" data-toggle="modal">
      {{ '_' | jtext: 'COM_JKASSA_YOUR_REVIEWS' }}
      <span class="badge pull-right">{{ reviews_quantity }}</span>
    </a>
  </li>
  {% endif %}
  {% if affiliate %}
  <li>
    <a href="{{ affiliate_route }}">
      {{ '_' | jtext: 'COM_JKASSA_AFFILIATE_PROGRAM' }}
    </a>
  </li>
  {% endif %}
</ul>

{% if posttext %}
<!--Posttext-->
<div>
  {{ posttext }}
</div>
{% endif %}

{% if guest %}
  {% comment %}
    Madal body for Login.
  {% endcomment %}
  <script type="text/javascript">
    jQuery(function($){ $("#jk-modal_login").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
    jQuery(document).ready(function($) {
        $('#jk-modal_login').on('show.bs.modal', function() {
            $('body').addClass('modal-open');
            var modalBody = $(this).find('.modal-body');
            modalBody.find('iframe').remove();
            modalBody.prepend('<iframe class="iframe" src="{{ login_url }}" name="login_url" height="400px"></iframe>');
        }).on('shown.bs.modal', function() {
            var modalHeight = $('div.modal:visible').outerHeight(true),
            modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
            modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
            modalBodyHeight = $('div.modal-body:visible').height(),
            modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
            padding = document.getElementById('jk-modal_login').offsetTop,
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
  <div id="jk-modal_login" tabindex="-1" class="modal hide fade">
    <div class="modal-header">
      <button type="button" class="close novalidate" data-dismiss="modal">×</button>
      <h3>{{ '_' | jtext: 'COM_JKASSA_ACCOUNT_LOGIN' }}</h3>
    </div>
    <div class="modal-body"></div>
  </div>
{% endif %}

{% comment %}
  Madal body for Cart.
{% endcomment %}
<script type="text/javascript">
  jQuery(function($){ $("#jk-modal_cart").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
  jQuery(document).ready(function($) {
	  $('#jk-modal_cart').on('show.bs.modal', function() {
		  $('body').addClass('modal-open');
		  var modalBody = $(this).find('.modal-body');
		  modalBody.find('iframe').remove();
		  modalBody.prepend('<iframe class="iframe" src="{{ cart_url }}" name="cart_url" height="400px"></iframe>');
	  }).on('shown.bs.modal', function() {
		  var modalHeight = $('div.modal:visible').outerHeight(true),
		  modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
		  modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
		  modalBodyHeight = $('div.modal-body:visible').height(),
		  modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
		  padding = document.getElementById('jk-modal_cart').offsetTop,
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
{% capture title_cart %}{{ '_' | jtext: 'COM_JKASSA_YOUR_CART' }} <span class="badge">{{ cart_quantity }}</span>{% endcapture %}
<div id="jk-modal_cart" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
	<button type="button" class="close novalidate" data-dismiss="modal">×</button>
	<h3>{{ title_cart }}</h3>
  </div>
  <div class="modal-body"></div>
</div>

{% comment %}
  Madal body for Viewed.
{% endcomment %}
<script type="text/javascript">
  jQuery(function($){ $("#jk-modal_viewed").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
  jQuery(document).ready(function($) {
	  $('#jk-modal_viewed').on('show.bs.modal', function() {
		  $('body').addClass('modal-open');
		  var modalBody = $(this).find('.modal-body');
		  modalBody.find('iframe').remove();
		  modalBody.prepend('<iframe class="iframe" src="{{ viewed_url }}" name="viewed_url" height="400px"></iframe>');
	  }).on('shown.bs.modal', function() {
		  var modalHeight = $('div.modal:visible').outerHeight(true),
		  modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
		  modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
		  modalBodyHeight = $('div.modal-body:visible').height(),
		  modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
		  padding = document.getElementById('jk-modal_viewed').offsetTop,
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
{% capture title_viewed %}{{ '_' | jtext: 'COM_JKASSA_VIEWED' }} <span class="badge">{{ viewed_quantity }}</span>{% endcapture %}
<div id="jk-modal_viewed" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
	<button type="button" class="close novalidate" data-dismiss="modal">×</button>
	<h3>{{ title_viewed }}</h3>
  </div>
  <div class="modal-body"></div>
</div>

{% comment %}
  Madal body for Wishlist.
{% endcomment %}
<script type="text/javascript">
  jQuery(function($){ $("#jk-modal_wishlist").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
  jQuery(document).ready(function($) {
	  $('#jk-modal_wishlist').on('show.bs.modal', function() {
		  $('body').addClass('modal-open');
		  var modalBody = $(this).find('.modal-body');
		  modalBody.find('iframe').remove();
		  modalBody.prepend('<iframe class="iframe" src="{{ wishlist_url }}" name="wishlist_url" height="400px"></iframe>');
	  }).on('shown.bs.modal', function() {
		  var modalHeight = $('div.modal:visible').outerHeight(true),
		  modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
		  modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
		  modalBodyHeight = $('div.modal-body:visible').height(),
		  modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
		  padding = document.getElementById('jk-modal_wishlist').offsetTop,
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
{% capture title_wishlist %}{{ '_' | jtext: 'COM_JKASSA_YOUR_WISHLIST' }} <span class="badge">{{ wishlist_quantity }}</span>{% endcapture %}
<div id="jk-modal_wishlist" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
	<button type="button" class="close novalidate" data-dismiss="modal">×</button>
	<h3>{{ title_wishlist }}</h3>
  </div>
  <div class="modal-body"></div>
</div>

{% comment %}
  Madal body for Compare.
{% endcomment %}
<script type="text/javascript">
  jQuery(function($){ $("#jk-modal_compare").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
  jQuery(document).ready(function($) {
	  $('#jk-modal_compare').on('show.bs.modal', function() {
		  $('body').addClass('modal-open');
		  var modalBody = $(this).find('.modal-body');
		  modalBody.find('iframe').remove();
		  modalBody.prepend('<iframe class="iframe" src="{{ compare_url }}" name="compare_url" height="400px"></iframe>');
	  }).on('shown.bs.modal', function() {
		  var modalHeight = $('div.modal:visible').outerHeight(true),
		  modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
		  modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
		  modalBodyHeight = $('div.modal-body:visible').height(),
		  modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
		  padding = document.getElementById('jk-modal_compare').offsetTop,
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
{% capture title_compare %}{{ '_' | jtext: 'COM_JKASSA_COMPARE_PRODUCTS' }} <span class="badge">{{ compare_quantity }}</span>{% endcapture %}
<div id="jk-modal_compare" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
	<button type="button" class="close novalidate" data-dismiss="modal">×</button>
	<h3>{{ title_compare }}</h3>
  </div>
  <div class="modal-body"></div>
</div>

{% comment %}
  Madal body for Orders.
{% endcomment %}
<script type="text/javascript">
  jQuery(function($){ $("#jk-modal_orders").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
  jQuery(document).ready(function($) {
	  $('#jk-modal_orders').on('show.bs.modal', function() {
		  $('body').addClass('modal-open');
		  var modalBody = $(this).find('.modal-body');
		  modalBody.find('iframe').remove();
		  modalBody.prepend('<iframe class="iframe" src="{{ orders_url }}" name="orders_url" height="400px"></iframe>');
	  }).on('shown.bs.modal', function() {
		  var modalHeight = $('div.modal:visible').outerHeight(true),
		  modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
		  modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
		  modalBodyHeight = $('div.modal-body:visible').height(),
		  modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
		  padding = document.getElementById('jk-modal_orders').offsetTop,
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
{% capture title_orders %}{{ '_' | jtext: 'COM_JKASSA_YOUR_ORDERS' }} <span class="badge">{{ orders_quantity }}</span>{% endcapture %}
<div id="jk-modal_orders" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
	<button type="button" class="close novalidate" data-dismiss="modal">×</button>
	<h3>{{ title_orders }}</h3>
  </div>
  <div class="modal-body"></div>
</div>

{% comment %}
  Madal body for reviews.
{% endcomment %}
<script type="text/javascript">
  jQuery(function($){ $("#jk-modal_reviews").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
  jQuery(document).ready(function($) {
	  $('#jk-modal_reviews').on('show.bs.modal', function() {
		  $('body').addClass('modal-open');
		  var modalBody = $(this).find('.modal-body');
		  modalBody.find('iframe').remove();
		  modalBody.prepend('<iframe class="iframe" src="{{ reviews_url }}" name="reviews_url" height="400px"></iframe>');
	  }).on('shown.bs.modal', function() {
		  var modalHeight = $('div.modal:visible').outerHeight(true),
		  modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
		  modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
		  modalBodyHeight = $('div.modal-body:visible').height(),
		  modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
		  padding = document.getElementById('jk-modal_reviews').offsetTop,
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
{% capture title_reviews %}{{ '_' | jtext: 'COM_JKASSA_YOUR_REVIEWS' }} <span class="badge">{{ reviews_quantity }}</span>{% endcapture %}
<div id="jk-modal_reviews" tabindex="-1" class="modal hide fade">
  <div class="modal-header">
	<button type="button" class="close novalidate" data-dismiss="modal">×</button>
	<h3>{{ title_reviews }}</h3>
  </div>
  <div class="modal-body"></div>
</div>