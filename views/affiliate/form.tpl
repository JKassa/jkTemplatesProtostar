{% if pretext %}
<!--Pretext-->
<div>
	{{ pretext }}
</div>
{% endif %}
<form action="{{ action }}" method="post" class="form-horizontal" id="jkAffiliateForm">
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
	{% if contacts_fields %}
	<!--Contacts fields-->
	<fieldset class="m-t-15">
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
	{% if rules %}
	<!--Shop rules-->
	<label class="checkbox m-t-15">
		{{ 'bootstrap.modal' | jhtml: 'jk-modal_rules' }}
		<input type="checkbox" id="jk_rules" name="jk_rules" value="1">
		<a href="#jk-modal_rules" data-toggle="modal">
			{{ '_' | jtext: 'COM_JKASSA_AFFILIATE_CHECK_RULES' }}
		</a>
	</label>
	{% endif %}
	<input type="submit" data-click="affiliate-form" class="btn btn-info m-t-15" value="{{ '_' | jtext: 'JSAVE' }}">
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
	jQuery(function ($) {
		"use strict";
		$("#jk-modal_rules").modal({
			"backdrop": true,
			"keyboard": true,
			"show": false,
			"remote": ""
		});
	});
	jQuery(document).ready(function ($) {
		"use strict";
		$('#jk-modal_rules').on('show.bs.modal', function () {
			$('body').addClass('modal-open');
		}).on('shown.bs.modal', function () {
			var modalHeaderHeight = $('div.modal-header:visible').outerHeight(true),
				modalBodyHeightOuter = $('div.modal-body:visible').outerHeight(true),
				modalBodyHeight = $('div.modal-body:visible').height(),
				modalFooterHeight = $('div.modal-footer:visible').outerHeight(true),
				padding = document.getElementById('jk-modal_rules').offsetTop,
				maxModalHeight = ($(window).height() - (padding * 2)),
				modalBodyPadding = (modalBodyHeightOuter - modalBodyHeight),
				maxModalBodyHeight = maxModalHeight - (modalHeaderHeight + modalFooterHeight + modalBodyPadding);
			var iframeHeight = $('.iframe').height();
			if (iframeHeight > maxModalBodyHeight) {
				$('.modal-body').css({
					'max-height': maxModalBodyHeight,
					'overflow-y': 'auto'
				});
				$('.iframe').css('max-height', maxModalBodyHeight - modalBodyPadding);
			}
		}).on('hide.bs.modal', function () {
			$('body').removeClass('modal-open');
			$('.modal-body').css({
				'max-height': 'initial',
				'overflow-y': 'initial'
			});
			$('.modalTooltip').tooltip('destroy');
		});
	});
</script>
<div id="jk-modal_rules" tabindex="-1" class="modal hide fade">
	<div class="modal-header">
		<button type="button" class="close novalidate" data-dismiss="modal">×</button>
		<h3>{{ '_' | jtext: 'COM_JKASSA_AFFILIATE_RULES' }}</h3>
	</div>
	<div class="modal-body">
		{{ rules }}
	</div>
</div>
{% endif %}