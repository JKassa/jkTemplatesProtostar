{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}

<form action="{{ form_action }}" name="modSearchForm" id="modSearchForm" method="get" class="form-search" style="width: {{ width_form }}px; margin: 10px auto">
  <div class="input-append">
    <input type="text" name="searchword" maxlength="{{ maxlength }}" class="search-query" placeholder="{{ '_' | jtext: 'MOD_JKASSA_SEARCH_PLACEHOLDER' }}" style="width: {{ width_form | minus: 96 }}px">
    <button type="submit" class="btn">
      {{ '_' | jtext: 'MOD_JKASSA_SEARCH_SEARCHBUTTON' }}
    </button>
  </div>
  <div id="jk-search-autocomplete"></div>
  <input type="hidden" name="view" value="search" />
  <input type="hidden" name="option" value="com_jkassa" />
</form>