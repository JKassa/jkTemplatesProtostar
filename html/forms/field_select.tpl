<div class="control-group"{% if field.showon %} data-showon='{{ field.showon }}'{% endif %}>
  <label class="control-label" for="{{ field.name }}">
    {{ field.label }}{% if field.required %} <span class="star text-error">*</span>{% endif %}
  </label>
  <div class="controls">
    <span{% if field.tooltip %} class="hasTooltip" title="{{ field.tooltip }}" data-placement="right"{% endif %}>
      <select
      	name="{{ field.name }}"
        id="{{ field.name }}"
        {% if field.required %} required{% endif %}
        {% if field.readonly %} disabled{% endif %}
        {% if field.onchange %} onchange="{{ field.onchange }}"{% endif %}>
        {% for val in field.values %}
        <option value="{{ val.value }}"{% if field.default == val.value %} selected{% endif %}>{{ val.text }}</option>
        {% endfor %}
      </select>
    </span>
  </div>
</div>