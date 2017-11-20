{{ 'stylesheet' | jhtml: 'css/style.css' }}
{% assign options = 'active' | arrayCombine: 'filterCost' %}

<form action="{{ action }}" method="post" id="mod_jkassa_filter_form">
  {{ 'bootstrap.startAccordion' | jhtml: 'filtersAccordian', options }}
  
    {% if filter_cost %}
    <!--Filter cost-->
    {% assign title_slide = 'sprintf' | jtext: 'MOD_JKASSA_FILTER_COST', symbol %}
    {{ 'bootstrap.addSlide' | jhtml: 'filtersAccordian', title_slide, 'filterCost' }}
      <!--Slider-->
      {% if slider %}
      <div class="jk-slider-filter">
        <div id="jk_slider_filter"></div>
      </div>
      <script type="text/javascript">
		// slide fix conflict with mootools
		if (typeof jQuery != 'undefined' && typeof MooTools != 'undefined' ) {
			Element.implement({
				slide: function(how, mode){
					return this;
				}
			});
		}
	  </script>
      {% endif %}
      <!--Costs-->
      <div class="row-fluid">
        <div class="input-prepend span6">
          <span class="add-on">{{ '_' | jtext: 'MOD_JKASSA_FILTER_ON' }}</span>
          <input type="text" id="min_cost" name="min_cost" placeholder="{{ min_default }}" class="input-mini" value="{{ min_cost }}" />
        </div>
        <div class="input-append span6">
          <input type="text" id="max_cost" name="max_cost" placeholder="{{ max_default }}" class="input-mini" value="{{ max_cost }}" />
          <span class="add-on">{{ '_' | jtext: 'MOD_JKASSA_FILTER_TO' }}</span>
        </div>
      </div>
    {{ 'bootstrap.endSlide' | jhtml }}
    {% endif %}
    
    {% if manufacturers %}
    <!--Filter manufacturers-->
    {% assign title_slide = '_' | jtext: 'MOD_JKASSA_FILTER_MANUFACTURERS' %}
    {{ 'bootstrap.addSlide' | jhtml: 'filtersAccordian', title_slide, 'filterManufacturers' }}
      {% for manufacturer in manufacturers %}
      <label class="checkbox">
        {% if manufacturer.thumbnail %}
        <img src="{{ manufacturer.thumbnail }}" alt="{{ manufacturer.alias }}" style="max-height: 50px; max-width: 50px;" />
        {% endif %}
        <input
          id="manufacturer_{{ manufacturer.id }}"
          type="checkbox"
          name="manufacturer[]"
          value="{{ manufacturer.id }}"
          {% if manufacturer.checked %}checked{% endif %}
        />
        {{ manufacturer.name }}
        {% if manufacturer.products %}
        <small class="muted">
          ({{ manufacturer.products }})
        </small>
        {% endif %}
      </label>
      {% endfor %}
    {{ 'bootstrap.endSlide' | jhtml }}
    {% endif %}
    
    {% if attributes %}
      <!--Filter attributes-->
      {% for attribute in attributes %}
        {% capture id_slide %}filterAttribute_{{ attribute.id }}{% endcapture %}
        {% capture title_slide %}
          {{ attribute.name }}
          {% if attribute.tooltip %}
          <span class="hasTooltip" title="{{ attribute.tooltip }}">
            <span class="icon-help icon-info-sign"></span>
          </span>
          {% endif %}
        {% endcapture %}
        {{ 'bootstrap.addSlide' | jhtml: 'filtersAccordian', title_slide, id_slide }}
          {% for value in attribute.values %}
          <label class="checkbox">
            <input
              id="attribute_{{ attribute.id }}_{{ value.key }}"
              type="checkbox"
              name="attribute[{{ attribute.id }}][]"
              value="{{ value.val }}"
              {% if value.checked %}checked{% endif %}
              {% if value.disabled %}disabled{% endif %}
            />
            {% if value.disabled %}<small class="muted">{% endif %}
            {{ value.val }} {{ attribute.prefix }}
            {% if value.disabled %}</small>{% endif %}
            {% if value.count %}
            <small class="muted">
              ({{ value.count }})
            </small>
            {% endif %}
          </label>
          {% endfor %}
        {{ 'bootstrap.endSlide' | jhtml }}
      {% endfor %}
    {% endif %}
  {{ 'bootstrap.endAccordion' | jhtml }}
  
  {% if show_ok or show_reset %}
  <!--Buttons-->
  <div class="btn-group m-t-10">
    {% if show_ok %}
    <button type="button" class="btn btn-small btn-primary" data-click="submit-filter">
      <span class="icon-checkmark icon-ok icon-white"></span>
      {{ '_' | jtext: 'MOD_JKASSA_FILTER_OK' }}
    </button>
    {% endif %}
    {% if show_reset %}
    <button type="button" class="btn btn-small" data-click="reset-filter">
      <span class="icon-loop icon-refresh"></span>
      {{ '_' | jtext: 'MOD_JKASSA_FILTER_RESET' }}
    </button>
    {% endif %}
  </div>
  {% endif %}
</form>