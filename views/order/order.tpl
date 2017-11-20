<div class="thumbnails">
  <div class="thumbnail m-t-30 p-10">
    <!--Header-->
    <div class="page-header">
      <span class="pull-right">
        <a href="{{ cart_url }}">
          <span class="icon-pencil"></span>
          {{ '_' | jtext: 'JACTION_EDIT' }}
        </a>
      </span>
      <h4>
        {{ '_' | jtext: 'COM_JKASSA_YOUR_ORDER' }}
      </h4>
    </div>
    
    <!--Products-->
    {% for product in products %}
    <div class="row-fluid jk-table-body">
      <!--Product Image-->
      <div class="span4">
        <div class="product-image">
          {% if product.discount %}
          <ul class="stickers">
            <li>
              <span class="product-label">-{{ product.discount | costDisplay }}{{ product.d_symbol }}</span>
            </li>
          </ul>
          {% endif %}
          <a href="{{ product.url }}" target="_blank">
            <img {{ product.image | img_exists: '88x127' }} alt="{{ product.alias }}" title="{{ product.name }}" />
          </a>
        </div>
      </div>
      <!--Product Information-->
      <div class="span8">
        <!--Name-->
        <strong>
          <a href="{{ product.url }}" target="_blank">
            {{ product.name }}
          </a>
          {% if product.present %}
          <!--present-->
          +
          <a href="{{ product.present.url }}" target="_blank">
            {{ product.present.name }}
          </a>
          {% endif %}
          {% if product.files %}
          <!--files-->
          <span title="<strong>{{ '_' | jtext: 'COM_JKASSA_ATTACHMENT' }}:</strong><br>{{ product.files | join: '<br>' }}" class="hasTooltip">
            <span class="icon-flag-2 icon-download"></span>
          </span>
          {% endif %}
        </strong>
        
        {% if product.sku %}
        <!--SKU (code)-->
        <div class="muted small text-right m-t-5">
          {{ '_' | jtext: 'COM_JKASSA_SKU' }}: {{ product.sku }}
        </div>
        {% endif %}
          
        {% if product.variants %}
        <!--Variants-->
        <div class="small m-t-10">
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
              {% when 'select' %}
                <span>
                  {{ variant.value }}
                </span>
            {% endcase %}
          {% endfor %}
        </div>
        {% endif %}
        
        {% if product.old_cost %}
        <!--Old cost-->
        <div class="m-t-10">
          <del>{{ product.old_cost | costDisplay }}{{ currency.symbol }}</del>
        </div>
        {% endif %}
      </div>
      <!--Product price-->
      <div class="span12 m-l-0 p-b-0">
        <div class="span5 text-left">
          <!--cost-->
          {{ product.cost | costDisplay }}{{ currency.symbol }}
        </div>
        <div class="span2 text-center">
          &times;{{ product.quantity }}
        </div>
        <div class="span5 text-right">
          <!--Price-->
          {{ product.price | costDisplay }}{{ currency.symbol }}
        </div>
      </div>
	  {% if product.vat %}
	  <div class="span12 m-l-0 p-t-0">
	    <div class="span6 text-left">
		  {{ 'sprintf' | jtext: 'COM_JKASSA_VAT_INCL', product.vat }}
		</div>
		<div class="span6 text-right">
		  {{ product.vat_cost }}{{ currency.symbol }}
		</div>
	  </div>
	  {% endif %}
    </div>
    {% endfor %}
    
    <!--Table footer-->
    <div class="jk-table-footer row-fluid text-right">
      <!-- Total price -->
      <div class="span7 m-l-0"><strong>{{ '_' | jtext: 'COM_JKASSA_SUM' }}:</strong></div>
      <div class="span5 m-l-0 cost"><span>{{ total | costDisplay }}</span>{{ currency.symbol }}</div>
      {% if discounts.sum %}
      <!--Discounts sum-->
      <div class="span7 m-l-0"><strong>{{ discounts.sum.name }}:</strong></div>
      <div class="span5 m-l-0">
        -{{ discounts.sum.difference | costDisplay }}{{ currency.symbol }}
        {% if discounts.sum.desc %}
        <span class="icon-help icon-info-sign hasTooltip" title="{{ discounts.sum.desc }}"></span>
        {% endif %}
      </div>
      {% endif %}
      {% if discounts.code %}
      <!--Discounts code-->
      <div class="span7 m-l-0"><strong>{{ discounts.code.name }}:</strong></div>
      <div class="span5 m-l-0">
        -{{ discounts.code.difference }}{{ currency.symbol }}
        {% if discounts.code.desc %}
        <span class="icon-help icon-info-sign hasTooltip" title="{{ discounts.code.desc }}"></span>
        {% endif %}
      </div>
      {% endif %}
      {% if delivery_cost %}
      <!--Delivery cost-->
      <div class="span7 m-l-0"><strong>{{ '_' | jtext: 'COM_JKASSA_ORDER_DELIVERY' }}:</strong></div>
      <div class="span5 m-l-0">
        {% if delivery_cost == '0.00' %}
          {{ '_' | jtext: 'COM_JKASSA_FREE' }}
        {% else %}
          {{ delivery_cost | costDisplay }}{{ currency.symbol }}
        {% endif %}
      </div>
      {% endif %}
	  {% if sum_vat %}
	  <!--Sum of VAT-->
	  <div class="span7 m-l-0"><strong>{{ '_' | jtext: 'COM_JKASSA_VAT' }}:</strong></div>
	  <div class="span5 m-l-0">
	    {{ sum_vat | costDisplay }}{{ currency.symbol }}
	  </div>
	  {% endif %}
	  {% if taxes %}
	  <!--Taxes-->
	  {% for tax in taxes %}
	  <div class="span7 m-l-0"><strong>{{ tax.name }}:</strong></div>
	  <div class="span5 m-l-0">
	    {{ tax.tax }}%
		{% if tax.description %}
        <span class="icon-help icon-info-sign hasTooltip" title="{{ tax.description }}"></span>
        {% endif %}
	  </div>
	  {% endfor %}
	  {% endif %}
      <!--In total price-->
      <div class="span12 m-l-0">
        <span class="lead text-info">
          {{ in_total | costDisplay }}{{ currency.symbol }}
        </span>
      </div>
      {% if coupon %}
      <!--Coupons code-->
      <div class="span12 m-l-0 form-inline">
        <a data-click="code-toggle" href="#">
          <span class="icon-key icon-gift"></span>
          {{ '_' | jtext: 'COM_JKASSA_ORDER_CODE_USE' }}
        </a>
        <div id="code-toggle" style="display: none">
          <input type="text" id="coupons_code" placeholder="{{ '_' | jtext: 'COM_JKASSA_ORDER_CODE_ENTER' }}" class="input-small" value="{{ coupon.value }}">
          <button data-click="code-apply" class="btn" type="button">{{ '_' | jtext: 'COM_JKASSA_APPLY' }}</button>
        </div>
        {% if coupon.note %}
        <div class="alert alert-danger" id="coupons_note">
          {{ coupon.note }}
        </div>
        {% endif %}
        <script type="text/javascript">
          jQuery('[data-click=code-toggle]').click(function(event) {
              event.preventDefault();
              jQuery('#code-toggle').slideToggle();
              jQuery('#coupons_note').remove();
          });
        </script>
      </div>
      {% endif %}
    </div>
  </div>
</div>