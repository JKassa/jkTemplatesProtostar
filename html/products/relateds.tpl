<div class="row-fluid jk-relateds">
  <ul class="thumbnails center">
    {% for related in relateds %}
    <li class="span3">
      <div class="over-wraper">
        <div class="thumbnail over-wraper-long">
          <!--Product Image-->
          <div class="product-image">
            <img {{ related.image | img_exists: '50x70' }} style="max-height: 70px;" alt="{{ related.alias }}" />
          </div>
          <div class="caption">
            <!--Name and URL of the product-->
            <h5>
              <a href="{{ related.url }}">
                {{ related.name }}
              </a>
            </h5>
            <!--SKU (code)-->
            <div class="muted small m-t-5">
              {{ '_' | jtext: 'COM_JKASSA_SKU' }}: {{ related.sku }}
            </div>
            <!--Price the product-->
            <div class="m-t-5">
              {% if related.old_cost %}
              <!--old cost-->
              <del>{{ related.old_cost }}{{ currency.symbol }}</del>
              {% endif %}
              <!--cost-->
              {{ related.cost }}{{ currency.symbol }}
            </div>
            <!--Add to cart-->
            <div class="m-t-10" >
              <a href="#" class="btn btn-mini btn-info" data-click="to-cart" data-id="{{ related.id }}" title="{{ 'sprintf' | jtext: 'COM_JKASSA_TO_CART_TITLE', related.name }}">
                <span class="icon-plus"></span>
                {{ '_' | jtext: 'COM_JKASSA_ADD' }}
              </a>
            </div>
          </div>
        </div>
      </div>
    </li>
    {% endfor %}
  </ul>
</div>