{{ 'stylesheet' | jhtml: 'css/style.css' }}

{% if image %}
  {% assign span = 'span4' %}
{% else %}
  {% assign span = 'span6' %}
{% endif %}

<div id="jk-cart-module" class="row-fluid {{ class_sfx }}">
  <ul class="unstyled thumbnail span12">
    {% if image %}
    <!--Cart image-->
    <li class="{{ span }} text-center">
      <a href="{{ url_cart }}">
        <img alt="cart" src="{{ image }}" title="{{ image_title }}">
      </a>
    </li>
    {% endif %}
    <li class="{{ span }}">
      {% if products %}
      <!--List products-->
      <ol>
        {% for product in products %}
        <li>
          <a href="{{ product.url }}">
            {{ product.name }}
          </a>
          
          {% if product.variants %}
          <br>
          <small>
            {% for variant in product.variants %}
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
			  {% when 'texture' %}
              <span class="minicolors-swatch">
				<img src="{{ variant.img }}" alt="{{ variant.alt }}" title="{{ variant.title }}">
              </span>
              {% when 'select' %}
              <span>
                {{ variant.value }}
              </span>
              {% endcase %}
            {% endfor %}
          </small>
          {% endif %}
          
          <br>
          {% if product.old_cost | costDisplay %}
          <!--old cost-->
          <del>{{ product.old_cost }}{{ currency.symbol }}</del>
          {% endif %}
          <!--cost-->
          <strong>{{ product.cost | costDisplay }}{{ currency.symbol }}</strong>
          <small>({{ product.quantity }})</small>
          <!--remove product-->
          <a href="javascript:;" data-click="remove-product" data-index="{{ product.index }}" data-id="{{ product.id }}" title="{{ '_' | jtext: 'MOD_JKASSA_CART_REMOVE' }}" data-toggle="tooltip"><span class="icon-remove text-error" style="font-size:10px"></span></a>
        </li>
        {% endfor %}
      </ol>
      {% else %}
        {% if text_empty %}
        <!--Text empty cart-->
        <div class="alert alert-info m-t-10">
          {{ text_empty }}
        </div>
        {% endif %}
      {% endif %}
    </li>
    <li class="{{ span }}">
      <!--Quantity-->
      <p class="text-center">
        {% capture cart_quantity %}<strong>{{ quantity }}</strong>{% endcapture %}
        {{ 'sprintf' | jtext: 'MOD_JKASSA_CART_COUNT', cart_quantity }}
      </p>
      
      {% if products %}
      <!--Cart total-->
      <p class="text-center">
        {% capture cart_total %}<strong>{{ total | costDisplay }}{{ currency.symbol }}</strong>{% endcapture %}
        {{ 'sprintf' | jtext: 'MOD_JKASSA_CART_AMOUNT', cart_total }}
      </p>
      
      <!--URL cart-->
      <p class="text-center">
        <a class="btn btn-small" href="{{ url_cart }}">
          <i class="icon-cart icon-shopping-cart"></i> {{ '_' | jtext: 'MOD_JKASSA_CART_YOUR_CART' }}
        </a>
      </p>
      <!--URL order-->
      <p class="text-center">
        <a class="btn btn-small btn-primary" href="{{ url_order }}">
          <i class="icon-arrow-right icon-chevron-right icon-white"></i> {{ '_' | jtext: 'MOD_JKASSA_CART_CART_ORDER' }}
        </a>
      </p>
      {% endif %}
    </li>
  </ul>
</div>