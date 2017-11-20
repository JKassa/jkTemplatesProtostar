{{ 'stylesheet' | jhtml: 'css/style.css' }}

<form action="{{ action }}" method="post" id="mod_jkassa_filter_form">
  <ul class="nav nav-tabs" id="filtersTabs">
    {% if filter_cost %}
    <li class="{% if active == 'cost' %}active{% endif %}">
      <a href="#filterCost">{{ 'sprintf' | jtext: 'MOD_JKASSA_FILTER_COST', symbol }}</a>
    </li>
    {% endif %}
    {% if manufacturers %}
    <li class="{% if active == 'manufacturers' %}active{% endif %}">
      <a href="#filterManufacturers">{{ '_' | jtext: 'MOD_JKASSA_FILTER_MANUFACTURERS' }}</a>
    </li>
    {% endif %}
    {% if attributes %}
    <li class="{% if active == 'attributes' %}active{% endif %}">
      <a href="#filterAttributes">{{ '_' | jtext: 'MOD_JKASSA_FILTER_MORE_FILTERS' }}</a>
    </li>
    {% endif %}
  </ul>
  <div class="tab-content">
    {% if filter_cost %}
    <!--Filter cost-->
    <div class="tab-pane{% if active == 'cost' %} active{% endif %}" id="filterCost">
      <!--Costs-->
      <div class="row-fluid">
        <div class="input-prepend span2">
          <span class="add-on">{{ '_' | jtext: 'MOD_JKASSA_FILTER_ON' }}</span>
          <input type="text" id="min_cost" name="min_cost" placeholder="{{ min_default }}" class="input-mini" value="{{ min_cost }}" />
        </div>
        <!--Slider-->
        {% if slider %}
        <div class="span4 jk-slider-filter">
          <div id="jk_slider_filter"></div>
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
        </div>
        <div class="input-append span2">
          <input type="text" id="max_cost" name="max_cost" placeholder="{{ max_default }}" class="input-mini" value="{{ max_cost }}" />
          <span class="add-on">{{ '_' | jtext: 'MOD_JKASSA_FILTER_TO' }}</span>
        </div>
      </div>
    </div>
    {% endif %}
    
    {% if manufacturers %}
    <!--Filter manufacturers-->
    <div class="tab-pane{% if active == 'manufacturers' %} active{% endif %}" id="filterManufacturers">
      <ul class="inline text-center">
        {% for manufacturer in manufacturers %}
        <li>
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
        </li>
        {% endfor %}
      </ul>
    </div>
    {% endif %}
    
    {% if attributes %}
    <!--Filter attributes-->
    <div class="tab-pane{% if active == 'attributes' %} active{% endif %}" id="filterAttributes">
      <div class="row-fluid horizontal-filters">
        {% for attribute in attributes %}
        <div class="span4">
          <h4>
            {{ attribute.name }}
            {% if attribute.tooltip %}
            <span class="hasTooltip" title="{{ attribute.tooltip }}">
              <span class="icon-help icon-info-sign"></span>
            </span>
            {% endif %}
          </h4>
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
        </div>
        {% endfor %}
      </div>
    </div>
    {% endif %}
    
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
  </div>
</form>
<script type="text/javascript">
  jQuery('#filtersTabs a').click(function (e) {
	e.preventDefault();
	jQuery(this).tab('show');
  });
</script>