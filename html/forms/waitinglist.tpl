{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}
{{ 'bootstrap.tooltip' | jhtml }}
{% assign options = 'disable_search_threshold' | arrayCombine: 20 %}
{{ 'formbehavior.chosen' | jhtml: 'select', null, options }}

<div class="row-fluid">
  <div class="span2 product-image">
    <img {{ image | img_exists: '104x150' }} alt="{{ alias }}" />
    {% if present %}
    <!--Share (Product as a present)-->
    <div class="share hasTooltip" title="{{ 'tooltipText' | jhtml: present.name, present.desc }}">
      <div class="sharetitle">
        {{ '_' | jtext: 'COM_JKASSA_GIFT' }}
      </div>
      <div class="sharedesc">
        <a href="{{ present.url }}">
          <img {{ present.image | img_exists: '50x50' }} alt="{{ present.name }}">
        </a>
      </div>
    </div>
    {% endif %}
  </div>
  <div class="span10">
    <h4>
      <a href="{{ url }}" target="_blank">
        {{ name }}
      </a>
      
      {% if files %}
      <!--Files-->
      <span title="<strong>{{ '_' | jtext: 'COM_JKASSA_ATTACHMENT' }}:</strong><br>{{ files | join: '<br>' }}" class="hasTooltip" data-placement="right">
        <span class="icon-flag-2 icon-download small"></span>
      </span>
      {% endif %}
    </h4>
    
    <!--SKU (code)-->
    <div class="muted small m-t-5">
      {{ '_' | jtext: 'COM_JKASSA_SKU' }}: {{ sku }}
    </div>
    
    {% if variants %}
    <div class="m-t-10">
      {% for variant in variants %}
        {{ variant.name }}:
        {% case variant.type %}
          {% when 'radio' %}
            <span class="variant-radio-value">
              {{ variant.text }}
            </span>
          {% when 'color' %}
            <span class="minicolors-swatch">
              <span style="background-color: {{ variant.value }};" title="{{ variant.text }}"></span>
            </span>
		  {% when 'texture' %}
			<span class="minicolors-swatch">
			  <img src="{{ variant.img }}" alt="{{ variant.alt }}" title="{{ variant.text }}">
			</span>
          {% when 'select' %}
            <span>
              {{ variant.text }}
            </span>
        {% endcase %}
      {% endfor %}
    </div>
    {% endif %}
    
    <!--Cost-->
    <div class="m-t-10">
      <!--old cost-->
      {% if old_cost %}
      <del>{{ old_cost }}{{ currency.symbol }}</del>
      {% endif %}
      <!--cost-->
      <span class="lead">{{ cost }}</span>{{ currency.symbol }}
	  {% if vat %}
	  <span class="muted small">
		({{ 'sprintf' | jtext: 'COM_JKASSA_VAT_INCL', vat }})
	  </span>
      {% endif %}
    </div>
  </div>
</div>

<hr>

<form action="{{ form_action }}" method="post" class="form-horizontal" id="waitingList">
  <fieldset>
    {% for field in fields %}
      {% case field.type %}
        {% when 'firstname' %}
          {% include 'html/forms/field_text' %}
        {% when 'email' %}
          {% include 'html/forms/field_email' %}
      {% endcase %}
    {% endfor %}
  </fieldset>
  <input type="submit" data-click="waitinglist-form" class="btn btn-info m-t-15" value="{{ '_' | jtext: 'JSUBMIT' }}">
</form>

<div class="alert alert-success alert-block" id="waitingListAlert" style="display:none">
  <h4>{{ '_' | jtext: 'COM_JKASSA_WAITINGLIST_N_1' }}</h4>
  {{ '_' | jtext: 'COM_JKASSA_WAITINGLIST_N_2' }}
</div>