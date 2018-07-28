{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}

<!-- Links -->
<p>
	<strong>{{ '_' | jtext: 'COM_JKASSA_AFFILIATE_LINK' }}:</strong><br>
	<code>{{ link }}</code>
</p>
<p>
	<strong>{{ '_' | jtext: 'COM_JKASSA_AFFILIATE_PRODUCT_LINK' }}:</strong><br>
	<code>{{ product_link }}</code>
</p>
<p>
	<span class="icon-flag"></span>
	<em>{{ '_' | jtext: 'COM_JKASSA_AFFILIATE_AFFILIATE_REWARD_PRODUCT' }}: <strong>{{ aff_income | costDisplay }}{{ currency.symbol }}</strong></em>
</p>