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

{% if cart_empty %}

<!--Cart empty-->
<div class="alert alert-block alert-info">
  <a data-dismiss="alert" class="close">&times;</a>
  <h4>{{ '_' | jtext: 'COM_JKASSA_CART_EMPTY_TITLE' }}!</h4>
  {% if user_guest %}
  {{ 'sprintf' | jtext: 'COM_JKASSA_CART_EMPTY_NOTE_GUEST', login_url }}
  {% else %}
  {{ '_' | jtext: 'COM_JKASSA_CART_EMPTY_NOTE' }}
  {% endif %}
</div>

{% else %}

{% capture access_note %}
  {% if access_form %}
  <!--You do not have access-->
  <div class="alert alert-block">
    <a data-dismiss="alert" class="close">&times;</a>
    <h4>{{ '_' | jtext: 'JGLOBAL_AUTH_ACCESS_GRANTED'  }}</h4>
    {{ '_' | jtext: 'COM_JKASSA_ORDER_FORM_ACCESS' }}
  </div>
  {% endif %}
{% endcapture %}

{% capture limit_note %}
  {% if limit_order %}
  <!--Minimum order amount-->
  <div class="alert alert-block">
    <a data-dismiss="alert" class="close">&times;</a>
    {% capture limit_cost %}{{ limit_order | costDisplay }}{{ currency.symbol }}{% endcapture %}
    <h4>{{ 'sprintf' | jtext: 'COM_JKASSA_LIMIT_ORDER', limit_cost  }}</h4>
    {{ '_' | jtext: 'COM_JKASSA_LIMIT_ORDER_NOTE' }}
  </div>
  {% endif %}
{% endcapture %}

<div class="row-fluid">
  <div class="span7">
    {% if user_guest %}
    <ul class="nav nav-tabs" id="orderTab">
      <li class="active">
        <a href="#new_user">{{ '_' | jtext: 'COM_JKASSA_ORDER_NEW_USER' }}</a>
      </li>
      <li>
        <a href="#client">{{ '_' | jtext: 'COM_JKASSA_ORDER_REGULAR_CLIENT' }}</a>
      </li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="new_user">
        {{ access_note }}{{ limit_note }}
        <!--Order form-->
        {{ form }}
      </div>
      <div class="tab-pane" id="client">
        <!--Login form-->
        {{ login_form }}
      </div>
    </div>
    <script type="text/javascript">
      jQuery('#orderTab a').click(function (e) {
        e.preventDefault();
        jQuery(this).tab('show');
      })
    </script>
    {% else %}
    {{ access_note }}{{ limit_note }}
    <!--Order form-->
    {{ form }}
    {% endif %}
  </div>
  <div class="span5">
    <!--Order-->
    {{ order }}
  </div>
</div>

{% endif %}

<!--Button: 'Continue Shopping'-->
<div class="text-center m-t-10">
  <a class="btn btn-large" href="{{ home_page }}">
    {{ '_' | jtext: 'COM_JKASSA_CART_CONTINUE_SHOPPING' }}
  </a>
</div>