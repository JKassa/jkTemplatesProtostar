<div class="control-group"{% if field.showon %} data-showon='{{ field.showon }}'{% endif %}>
  <label class="control-label" for="{{ field.name }}">
    {{ field.label }}{% if field.required %} <span class="star text-error">*</span>{% endif %}
  </label>
  <div class="controls">
    <input
    	type="tel"
        id="{{ field.name }}"
        name="{{ field.name }}"
        value="{{ field.default }}"
        {% if field.placeholder %} placeholder="{{ field.placeholder }}"{% endif %}
        {% if field.required %} required{% endif %}
        {% if field.readonly %} readonly{% endif %}
        {% if field.tooltip %} class="hasTooltip" title="{{ field.tooltip }}" data-placement="right"{% endif %}
        {% if field.masked %} data-masked="{{ field.masked }}"{% endif %}
    >
  </div>
</div>