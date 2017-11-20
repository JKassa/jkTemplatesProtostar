{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}

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

<!--Print icon-->
{% if print_screen == 0 %}
<div class="btn-group pull-right">
  <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
    <span class="icon-cog"></span>
    <span class="caret">&nbsp;</span>
  </a>
  <ul class="dropdown-menu actions">
    <li class="print-icon">{{ print_icon }}</li>
  </ul>
</div>
{% else %}
<div class="btn no-print" style="position: fixed; right: 10px; top: 10px">
  {{ print_screen }}
</div>
{% endif %}

<div class="text-center">
  {% if print_screen == 0 %}
  <img src="{{ image }}" alt="action" />
  {% endif %}
  
  <h1>{{ order_status }}</h1>
  <p>{{ description }}</p>
  
  {% if print_screen == 0 and action == 'pending' %}
  <a href="{{ update_url }}" class="button btn btn-large btn-warning">
    {{ '_' | jtext: 'COM_JKASSA_UPDATE_STATUS' }}
  </a>
  {% endif %}
  
  <hr />
  
  <h3>
    {{ 'sprintf' | jtext: 'COM_JKASSA_RESULT_NUMBER', pm_number }}
  </h3>
</div>

{% if note %}
<div class="alert">
  {{ note }}
</div>
{% endif %}

{% if print_screen == 0 %}
  <!--Order-->
  {% assign options = 'active' | arrayCombine: 'data_products' %}
  {{ 'bootstrap.startAccordion' | jhtml: 'resultAccordian', options }}
    <!--Information about order-->
    {% assign title_slide = '_' | jtext: 'COM_JKASSA_YOUR_PURCHASES' %}
    {{ 'bootstrap.addSlide' | jhtml: 'resultAccordian', title_slide, 'data_products' }}
      {% include 'views/result/products' %}
    {{ 'bootstrap.endSlide' | jhtml }}
    <!--Order data-->
    {% assign title_slide = '_' | jtext: 'COM_JKASSA_ORDER_DATA' %}
    {{ 'bootstrap.addSlide' | jhtml: 'resultAccordian', title_slide, 'data_payment' }}
      {% include 'views/result/payment' %}
    {{ 'bootstrap.endSlide' | jhtml }}
    <!--Data buyer-->
    {% assign title_slide = '_' | jtext: 'COM_JKASSA_DATA_BUYER' %}
    {{ 'bootstrap.addSlide' | jhtml: 'resultAccordian', title_slide, 'data_buyer' }}
      {% include 'views/result/buyer' %}
    {{ 'bootstrap.endSlide' | jhtml }}
    {% if delivery %}
    <!--Data delivery-->
    {% assign title_slide = '_' | jtext: 'COM_JKASSA_DATA_DELIVERY' %}
    {{ 'bootstrap.addSlide' | jhtml: 'resultAccordian', title_slide, 'data_delivery' }}
      {% include 'views/result/delivery' %}
    {{ 'bootstrap.endSlide' | jhtml }}
    {% endif %}
  {{ 'bootstrap.endAccordion' | jhtml }}
  
  <!--Continue shopping-->
  <p class="text-center">
    <a class="btn btn-large" href="{{ home_page }}">
      {{ '_' | jtext: 'COM_JKASSA_CART_CONTINUE_SHOPPING' }}
    </a>
  </p>
{% else %}
  <!--Print-->
  <h4>{{ '_' | jtext: 'COM_JKASSA_YOUR_PURCHASES' }}</h4>
  {% include 'views/result/products' %}
  <h4>{{ '_' | jtext: 'COM_JKASSA_ORDER_DATA' }}</h4>
  {% include 'views/result/payment' %}
  <h4>{{ '_' | jtext: 'COM_JKASSA_DATA_BUYER' }}</h4>
  {% include 'views/result/buyer' %}
  {% if delivery %}
  <h4>{{ '_' | jtext: 'COM_JKASSA_DATA_DELIVERY' }}</h4>
  {% include 'views/result/delivery' %}
  {% endif %}
{% endif %}

{% if posttext %}
<!--Posttext-->
<div class="m-t-15">
  {{ posttext }}
</div>
{% endif %}