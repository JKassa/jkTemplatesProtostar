<div class="jk_alert_dialog">
  <div class="jk_alert_header">
    {{ header }}
  </div>
  <div class="jk_alert_body">
    <div class="row-fluid">
      <div class="span3">
        <img src="{{ image }}" alt="{{ alias }}" />
      </div>
      <div class="span9">
        <!--Name-->
        <a href="{{ url }}">
          {{ name }}
        </a>
        {% if sku %}
        <!--SKU (code)-->
        <div class="muted small text-right m-t-5">
          {{ '_' | jtext: 'COM_JKASSA_SKU' }}: {{ sku }}
        </div>
        {% endif %}
        {% if variants %}
        <!--Variants-->
        <div class="small m-t-5">
          {% for variant in variants %}
            {{ variant.name }}:
            {% case variant.type %}
              {% when 'radio' %}
                <span class="variant-radio-value">
                  {{ variant.value }}
                </span>
              {% when 'color' %}
                <span class="minicolors-swatch">
                  <span style="background-color: {{ variant.value }};" title="{{ variant.title }}"></span>
                </span>
              {% when 'select' %}
                <span>
                  {{ variant.value }}
                </span>
            {% endcase %}
          {% endfor %}
        </div>
        {% endif %}
        <!--Cost-->
        <div class="m-t-5">
          {% if old_cost %}
          <del>{{ old_cost | costDisplay }}{{ currency.symbol }}</del>
          {% endif %}
          <span class="cost">
            <span>{{ cost | costDisplay }}</span>{{ currency.symbol }}
          </span>
          <br>
          {% if quantity %}
          <small class="muted">{{ '_' | jtext: 'COM_JKASSA_QUANTITY' }}: {{ quantity }}</small>
          {% endif %}
        </div>
      </div>
    </div>
  </div>
  <div class="jk_alert_footer">
    <a href="#" data-click="close-alert" class="btn">
      {{ '_' | jtext: 'COM_JKASSA_CART_CONTINUE_SHOPPING' }}
    </a>
    {% if event == 'to_cart' %}
    <a href="{{ url_order }}" class="btn btn-info pull-right">
      {{ '_' | jtext: 'COM_JKASSA_CHECKOUT' }}
    </a>
    {% endif %}
    {% if event == 'to_wishlist' %}
    <a href="{{ url_wishlist }}" class="btn btn-info pull-right">
      {{ '_' | jtext: 'COM_JKASSA_YOUR_WISHLIST' }}
    </a>
    {% endif %}
    {% if event == 'to_compare' %}
    <a href="{{ url_compare }}" class="btn btn-info pull-right">
      {{ '_' | jtext: 'COM_JKASSA_COMPARE_LIST' }}
    </a>
    {% endif %}
  </div>
</div>