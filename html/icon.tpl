{% case icon %}
	{% when 'print' %}
		<span class="print-icon icon-print"></span>
        {{ '_' | jtext: 'JGLOBAL_PRINT' }}
	{% when 'print_screen' %}
		<span class="print-icon icon-print"></span>
        {{ '_' | jtext: 'JGLOBAL_PRINT' }}
    {% when 'email' %}
		<span class="email-icon icon-envelope"></span>
        {{ '_' | jtext: 'JGLOBAL_EMAIL' }}
	{% when 'lock' %}
		<span class="icon-lock"></span>
        {{ '_' | jtext: 'JLIB_HTML_CHECKED_OUT' }}
    {% when 'close' %}
		<span class="icon-eye-close"></span>
        {{ '_' | jtext: 'JGLOBAL_EDIT' }}
    {% when 'edit' %}
		<span class="icon-edit icon-pencil"></span>
        {{ '_' | jtext: 'JGLOBAL_EDIT' }}
    {% when 'create' %}
		<span class="icon-plus"></span>
        {{ '_' | jtext: 'JNEW' }}
	{% when 'help' %}
		<span class="icon-help icon-info-sign hasTooltip" title="{{ tooltip }}"></span>
	{% when 'star' %}
		<span class="icon-star" style="color: #F2CD00"></span>
	{% when 'star-empty' %}
		<span class="icon-star-empty" style="color: #CCCCCC"></span>
	{% when 'big-star' %}
		<span class="icon-star" style="color: #F2CD00; font-size: 24px"></span>&nbsp;&nbsp;
	{% when 'big-star-empty' %}
		<span class="icon-star-empty" style="color: #CCCCCC; font-size: 24px"></span>&nbsp;&nbsp;
	{% when 'status_success' %}
		{% capture url %}jktemplates/{{ '' | templateName }}/images/status_success.png{% endcapture %}
		{{ url }}
	{% when 'status_new' %}
		{% capture url %}jktemplates/{{ '' | templateName }}/images/status_new.png{% endcapture %}
		{{ url }}
	{% when 'status_process' %}
		{% capture url %}jktemplates/{{ '' | templateName }}/images/status_process.png{% endcapture %}
		{{ url }}
	{% when 'status_fail' %}
		{% capture url %}jktemplates/{{ '' | templateName }}/images/status_fail.png{% endcapture %}
		{{ url }}
{% endcase %}