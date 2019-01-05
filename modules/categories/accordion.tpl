{% for category in categories %}
  {% capture collapseId %}collapseSlider-{{ category.id }}{% endcapture %}
  {% if category.active or category.active_parent %}
    {% assign active = ' in' %}
  {% else %}
    {% assign active = '' %}
  {% endif %}
  
  <div class="accordion-group">
    
    <div class="accordion-heading">
      <a class="accordion-toggle" data-toggle="collapse" data-parent="#{{ selector }}" href="#{{ collapseId }}">
        {{ category.title }}
        {% if category.qty_products %}
        <span class="badge pull-right">{{ category.qty_products }}</span>
        {% endif %}
      </a>
    </div>
    
    <div id="{{ collapseId }}" class="accordion-body collapse{{ active }}">
      <div class="accordion-inner">
        {% if category.image %}
        <a href="{{ category.url }}">
          <img src="{{ category.image }}" alt="{{ category.alias }}" style="display: block; max-height: 50px; max-width: 50px;" />
        </a>
        {% endif %}
        {% if category.description %}
        <p style="font-size: 10px; line-height: 10px;">
          {{ category.description | truncateDesc: 100 }}
        </p>
        {% endif %}
        <div style="clear: both;"></div>
        <p class="readmore" style="text-align: right;">
          <a href="{{ category.url }}" class="btn btn-mini" data-placement="left" title="{{ 'sprintf' | jtext: 'MOD_JKASSA_CATEGORIES_GO_TITLE', category.title }}">
            <span class="icon-arrow-right"></span>
            {{ '_' | jtext: 'MOD_JKASSA_CATEGORIES_GO' }}
          </a>
        </p>
      
    
        {% assign startTemp = start %}
        
        {% if category.children %}
          {% increment start %}
          {% capture selector %}mjkcategories-accordion-{{ start }}{% endcapture %}
          <div class="accordion" id="{{ selector }}">
            {% assign assigns = 'categories,start' | arrayCombine: category.children, start %}
            {{ assigns | layoutRender: 'modules/categories', 'accordion' }}
          </div>
        {% endif %}
        
        {% assign start = startTemp %}
    
      </div>
    </div>
    
  </div>
{% endfor %}