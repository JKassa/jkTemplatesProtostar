<!--Name form-->
<h3>
  {{ name }}
</h3>

{% if pretext %}
<!--Pretext-->
<div>
  {{ pretext }}
</div>
{% endif %}

<form action="{{ form_action }}" method="post" class="form-horizontal" id="jkOrderForm">
  {% if contacts_fields %}
  <!--Contacts fields-->
  <fieldset>
    <legend>{{ contacts_title }}</legend>
    {% for field in contacts_fields %}
      {% case field.type %}
        {% when 'firstname' %}
          {% include 'html/forms/field_text' %}
        {% when 'middlename' %}
          {% include 'html/forms/field_text' %}
        {% when 'lastname' %}
          {% include 'html/forms/field_text' %}
        {% when 'email' %}
          {% include 'html/forms/field_email' %}
        {% when 'phone' %}
          {% include 'html/forms/field_tel' %}
        {% when 'location' %}
          {% include 'html/forms/field_location' %}
        {% when 'address1' %}
          {% include 'html/forms/field_text' %}
        {% when 'address2' %}
          {% include 'html/forms/field_text' %}
        {% when 'postal_code' %}
          {% include 'html/forms/field_text' %}
        {% when 'website' %}
          {% include 'html/forms/field_url' %}
        {% when 'aboutme' %}
          {% include 'html/forms/field_textarea' %}
        {% when 'dob' %}
          {% include 'html/forms/field_calendar' %}
        {% when 'text' %}
          {% include 'html/forms/field_text' %}
        {% when 'textarea' %}
          {% include 'html/forms/field_textarea' %}
        {% when 'select' %}
          {% include 'html/forms/field_select' %}
        {% when 'radio' %}
          {% include 'html/forms/field_radio' %}
        {% when 'checkbox' %}
          {% include 'html/forms/field_checkbox' %}
        {% when 'mail' %}
          {% include 'html/forms/field_email' %}
        {% when 'tel' %}
          {% include 'html/forms/field_tel' %}
        {% when 'url' %}
          {% include 'html/forms/field_url' %}
	    {% when 'calendar' %}
          {% include 'html/forms/field_calendar' %}
      {% endcase %}
    {% endfor %}
  </fieldset>
  {% endif %}
  
  {% if delivery_fields %}
  <!--Delivery fields-->
  <fieldset>
    <legend>{{ delivery_title }}</legend>
    {% for delivery in delivery_fields %}
    <div{% if delivery.showon %} data-showon='{{ delivery.showon }}'{% endif %}>
      <label class="radio">
        <input
          type="radio"
          name="jk_delivery"
          id="{{ delivery.name }}"
          value="{{ delivery.name }}"
          {% if delivery.default %} checked{% endif %}
         >
        <strong>{{ delivery.label }}</strong>
        {% if delivery.cost != 0.00 %}
        <!--Cost of delivery-->
        <span class="help-block">
          {{ '_' | jtext: 'COM_JKASSA_COST_DELIVERY' }}:
		  <strong>{{ delivery.cost | costDisplay }}{{ currency.symbol }}</strong>
        </span>
        {% endif %}
        {% if delivery.free != 0.00 %}
        <!--Free delivery-->
        <span class="text-info">
          {{ '_' | jtext: 'COM_JKASSA_ORDER_FREE_DELIVERY' }}:
		  <strong>{{ delivery.free | costDisplay }}{{ currency.symbol }}</strong>
        </span>
        {% endif %}
        {% if delivery.tooltip %}
        <!--Description delivery-->
        <span class="help-block">
          {{ delivery.tooltip }}
        </span>
        {% endif %}
      </label>
	  
	  {% if delivery_add_fields %}
        <!--Additional fields for delivery-->
        {% for field in delivery_add_fields %}
		  {% if field.delivery == delivery.name %}
            {% case field.type %}
              {% when 'text' %}
                {% include 'html/forms/field_text' %}
              {% when 'textarea' %}
                {% include 'html/forms/field_textarea' %}
              {% when 'select' %}
                {% include 'html/forms/field_select' %}
              {% when 'radio' %}
                {% include 'html/forms/field_radio' %}
              {% when 'checkbox' %}
                {% include 'html/forms/field_checkbox' %}
              {% when 'calendar' %}
                {% include 'html/forms/field_calendar' %}
            {% endcase %}
		  {% endif %}
        {% endfor %}
      {% endif %}
    </div>
    {% endfor %}
  </fieldset>
  {% endif %}
  
  {% if payment_fields %}
  <!--Payment fields-->
  <fieldset>
    <legend>{{ payment_title }}</legend>
    {% for payment in payment_fields %}
    <div{% if payment.showon %} data-showon='{{ payment.showon }}'{% endif %}>
      <label class="radio">
        <input
          type="radio"
          name="jk_payment"
          id="{{ payment.name }}"
          value="{{ payment.name }}"
          {% if payment.default %} checked{% endif %}
        >
        <strong>{{ payment.label }}</strong>
        {% if payment.logo %}
        <br>
        <img src="{{ payment.logo }}" alt="{{ payment.name }}" class="img-polaroid" />
        {% endif %}
        {% if payment.tooltip %}
        <br>
        <span class="help-block">{{ payment.tooltip }}</span>
        {% endif %}
      </label>
	  
	  {% if payment_add_fields %}
        <!--Additional fields for payment-->
        {% for field in payment_add_fields %}
		  {% if field.payment == payment.name %}
            {% case field.type %}
              {% when 'text' %}
                {% include 'html/forms/field_text' %}
              {% when 'textarea' %}
                {% include 'html/forms/field_textarea' %}
              {% when 'select' %}
                {% include 'html/forms/field_select' %}
              {% when 'radio' %}
                {% include 'html/forms/field_radio' %}
              {% when 'checkbox' %}
                {% include 'html/forms/field_checkbox' %}
              {% when 'calendar' %}
                {% include 'html/forms/field_calendar' %}
            {% endcase %}
		  {% endif %}
        {% endfor %}
      {% endif %}
    </div>
    {% endfor %}
  </fieldset>
  {% endif %}
  
  {% if rules %}
  <!--Shop rules-->
  <label class="checkbox m-t-15">
    {{ 'bootstrap.modal' | jhtml: 'jk-modal_rules' }}
    <input type="checkbox" id="jk_rules" name="jk_rules" value="1">
    <a href="#jk-modal_rules" data-toggle="modal">
      {{ '_' | jtext: 'COM_JKASSA_ENABLEPROCESS' }}
    </a>
  </label>
  {% endif %}
  
  {% if captcha %}
  <!--CAPTCHA-->
  <div class="m-t-15">
    {{captcha}}
  </div>
  {% endif %}
  
  <input type="submit" data-click="order-form" class="btn btn-info m-t-15" value="{{ '_' | jtext: 'COM_JKASSA_SEND_ORDER' }}">
</form>

{% if posttext %}
<!--Posttext-->
<div>
  {{ posttext }}
</div>
{% endif %}

{% if rules %}
  {% comment %}
    Madal body for Rules.
  {% endcomment %}
  <script type="text/javascript">
    jQuery(function($){ $("#jk-modal_rules").modal({"backdrop": true,"keyboard": true,"show": false,"remote": ""}); });
    jQuery(document).ready(function($) {
        $('#jk-modal_rules').on('show.bs.modal', function() {
            $('body').addClass('modal-open');
            var modalBody = $(this).find('.modal-body');
        }).on('shown.bs.modal', function() {
            var modalHeight = $('div.modal:visible').outerHeight(true),
            modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
            modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
            modalBodyHeight = $('div.modal-body:visible').height(),
            modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
            padding = document.getElementById('jk-modal_rules').offsetTop,
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
  <div id="jk-modal_rules" tabindex="-1" class="modal hide fade">
    <div class="modal-header">
      <button type="button" class="close novalidate" data-dismiss="modal">×</button>
      <h3>{{ '_' | jtext: 'COM_JKASSA_SHOP_RULES' }}</h3>
    </div>
    <div class="modal-body">
      {{ rules }}
    </div>
  </div>
{% endif %}