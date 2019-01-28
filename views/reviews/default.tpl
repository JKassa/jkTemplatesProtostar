{% comment %}
	Connect CSS and JavaScript to the header of the document.
{% endcomment %}
{{ 'stylesheet' | jhtml: 'css/style.css' }}
{{ 'script' | jhtml: 'js/template.js' }}
{{ 'bootstrap.tooltip' | jhtml }}
{% assign options = 'disable_search_threshold' | arrayCombine: 20 %}
{{ 'formbehavior.chosen' | jhtml: 'select', null, options }}

{% if heading %}
<!--Heading-->
<h1>{{ heading }}</h1>
{% endif %}

{% if title %}
<!--Title-->
<div class="page-header">
	<h2>
		{{ title }}
		<small>({{ total }})</small>
	</h2>
</div>
{% endif %}

{% if pretext %}
<!--Pretext-->
<div>
  {{ pretext }}
</div>
{% endif %}

{% if reviews %}
<!--Filters-->
<form action="{{ form_action }}" method="post" name="reviewsForm" id="reviewsForm">
	<div class="page-header">
		<!--Sort by-->
		<span class="icon-filter" title="{{ '_' | jtext: 'COM_JKASSA_SORT_TITLE' }}"></span>
		<select onchange="this.form.submit()" name="filter_order" class="input-medium">
			{% for sort in sorting %}
			<option value="{{ sort.value }}"{{ sort.selected }}>{{ sort.title }}</option>
			{% endfor %}
		</select>
		<!--Limit-->
		<div class="pull-right">
			{{ '_' | jtext: 'JGLOBAL_DISPLAY_NUM' }}
			<select onchange="this.form.submit()" name="limit" title="{{ '_' | jtext: 'JSHOW' }}" class="input-medium" style="width: auto;">
				{% for limit in limits %}
				<option value="{{ limit.value }}"{{ limit.selected }}>{{ limit.title }}</option>
				{% endfor %}
			</select>
		</div>
	</div>
</form>

<!--Reviews-->
<div class="thumbnails">
	{% for review in reviews %}
	<div class="thumbnail">
		<div class="caption">
			<div class="media">
				<a class="pull-left" href="{{ review.product_url }}" style="width: 64px;">
					<img class="media-object" alt="{{ review.product_alias }}" style="max-width: 64px; max-height: 64px;" src="{{ review.product_image }}">
				</a>
				<div class="media-body">
					<h4 class="media-heading">
						<a href="{{ review.product_url }}">
							{{ review.product_name }}
						</a>
					</h4>
					<!--Rating reviews-->
					{% for i in (1..5) %}
						{% if review.product_rating >= i %}
						<span class="icon-star" style="color: #F2CD00"></span>
						{% else %}
						<span class="icon-star-empty" style="color: #CCCCCC"></span>
						{% endif %}
					{% endfor %}
					<br>
					<small>{{ 'plural' | jtext: 'COM_JKASSA_REVIEWS_COUNT', review.product_rating_count }}</small>
				</div>
			</div>
		</div>
		<hr class="m-t-0 m-b-0">
		<div class="caption">
			{% assign review_id     = review.id %}
			{% assign user_img      = review.user_img %}
			{% assign user_name     = review.user_name %}
			{% assign rating        = review.rating %}
			{% assign date     	    = review.date %}
			{% assign dignity       = review.dignity %}
			{% assign shortcomings  = review.shortcomings %}
			{% assign parent        = review.parent %}
			{% assign review_rating = review.review_rating %}
			{% assign children      = review.children %}
			{% assign product_id    = review.product_id %}
			{% assign review        = review.review %}
			{% include 'html/reviews/post' %}
		</div>
	</div>
	{% endfor %}
</div>
{% else %}
<div class="alert alert-no-items">
	{{ '_' | jtext: 'COM_JKASSA_REVIEWS_COUNT_0' }}
</div>
{% endif %}

{% if posttext %}
<!--Posttext-->
<div>
  {{ posttext }}
</div>
{% endif %}

{% comment %}
	Pages links (pagination).
	See: html/pagination
{% endcomment %}
{{ pagesLinks }}