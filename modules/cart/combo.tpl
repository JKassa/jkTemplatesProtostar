{{ 'stylesheet' | jhtml: 'css/style.css' }}

{% if image %}
  {% assign span = 'span9' %}
{% else %}
  {% assign span = 'span12' %}
{% endif %}

<div id="jk-cart-module" class="row-fluid m-b-20">
  {% if image %}
  <div class="span3 text-center">
    <a href="{{ url_cart }}">
      <img alt="cart" src="{{ image }}" title="{{ image_title }}">
    </a>
  </div>
  {% endif %}
  
  <div class="{{ span }}" style="white-space: nowrap;">
    {% if products %}
    <div class="help-block text-center">
      {{ 'plural' | jtext: 'MOD_JKASSA_CART_QUANTITY', quantity }}
      - {{ total | costDisplay }}{{ currency.symbol }}
    </div>
    <div class="help-block text-center">
      <a href="{{ url_cart }}" class="btn btn-mini">
        <i class="icon-cart icon-shopping-cart"></i> {{ '_' | jtext: 'MOD_JKASSA_CART_YOUR_CART' }}
      </a>
    </div>
    {% else %}
    <div class="help-block text-center">
      {{ 'plural' | jtext: 'MOD_JKASSA_CART_QUANTITY', quantity }}
    </div>
    {% endif %}
  </div>
</div>