<div id="reviewPost{{ review_id }}" class="media">
	<!--Img-->
	<span class="pull-left">
		<img src="{{ user_img }}" class="media-object img-circle" alt="{{ user_name }}" style="width: 64px; height: 64px;">
	</span>
	<div class="media-body">
		<!--Name / Rating / Date-->
		<h4 class="media-heading">
			{{ user_name }}
			{% if rating %}
			<span class="review-stars-small">
				<span class="review-star-small review-star-{{ rating }}"></span>
			</span>
			{% endif %}
			<small class="pull-right">
				<span class="icon-clock icon-time"></span> {{ date }}
			</small>
		</h4>
		<!--Review-->
		<div class="page-header" style="margin: 0;">
			{% if message %}
			<div class="alert alert-info">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				{{ message }}
			</div>
			{% endif %}
			<p>{{ review }}</p>
			{% if dignity %}
			<p><strong>{{ '_' | jtext: 'COM_JKASSA_REVIEWS_DIGNITY' }}:</strong> {{ dignity }}</p>
			{% endif %}
			{% if shortcomings %}
			<p><strong>{{ '_' | jtext: 'COM_JKASSA_REVIEWS_SHORTCOMINGS' }}:</strong> {{ shortcomings }}</p>
			{% endif %}
		</div>
		<!--Toolbar-->
		<div class="row-fluid">
			<div class="span6">
				{% if parent == 0 and access_reply != 1 %}
				<a href="#" data-click="show-reply" data-id="{{ review_id }}" class="btn btn-link">
					<span class="icon-share-alt"></span>
					{{ '_' | jtext: 'COM_JKASSA_REVIEWS_REPLY' }}
				</a>
				{% endif %}
			</div>
			<div class="span6 text-right">
				<!--Rating-->
				{% if parent == 0 %}
				<a href="#" data-click="reviews-rating" data-rating="1" data-id="{{ review_id }}" class="btn btn-link hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_HELPFUL' }}">
					<span class="icon-thumbs-up text-success"></span>
				</a>
				<span id="reviewRating{{ review_id }}" class="label">
					{{ review_rating }}
				</span>
				<a href="#" data-click="reviews-rating" data-rating="-1" data-id="{{ review_id }}" class="btn btn-link hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_NOT_HELPFUL' }}">
					<span class="icon-thumbs-down text-error"></span>
				</a>
				{% endif %}
				{% if access_report != 1 %}
				<!--Report-->
				<a href="#" data-click="show-report" data-id="{{ review_id }}" class="btn btn-link hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_REPORT_TITLE' }}">
					<span class="icon-warning icon-warning-sign text-warning"></span>
				</a>
				{% endif %}
			</div>
		</div>
		{% if parent == 0 and access_reply != 1 %}
		<!--Reply form-->
		<div class="review-popup" id="reviewReplyBlock{{ review_id }}" style="display: none">
			<form id="reviewReplyForm{{ review_id }}">
				<label for="reviewReplyReview">{{ '_' | jtext: 'MESSAGE' }}</label>
				<textarea id="reviewReview" name="reviewReview"></textarea>
				<label for="reviewReplyName">{{ '_' | jtext: 'COM_JKASSA_YOUR_NAME' }}</label>
				{% if reply_name %}{% assign readonly_name = ' readonly' %}{% endif %}
				<input type="text" id="reviewReplyName" name="reviewName" value="{{ reply_name }}"{{ readonly_name }}>
				<label for="reviewReplyEmail">{{ '_' | jtext: 'COM_JKASSA_YOUR_EMAIL' }}</label>
				{% if reply_email %}{% assign readonly_email = ' readonly' %}{% endif %}
				<input type="email" id="reviewReplyEmail" name="reviewEmail" value="{{ reply_email }}"{{ readonly_email }}>
				<span class="help-block"></span>
				<a href="#" class="btn" data-click="send-reply" data-id="{{ review_id }}" data-toadd="> .media-body">
					{{ '_' | jtext: 'JSUBMIT' }}
				</a>
				<input type="hidden" name="productID" value="{{ product_id }}">
			</form>
		</div>
		{% endif %}
		{% if access_report != 1 %}
		<!--Report form-->
		<div class="review-popup report-block" id="reviewReportBlock{{ review_id }}" style="display: none">
			<form id="reviewReportForm{{ review_id }}">
				<label for="reviewReport">{{ '_' | jtext: 'MESSAGE' }}</label>
				<textarea id="reviewReport" name="reviewReport"></textarea>
				<label for="reviewReportName">{{ '_' | jtext: 'COM_JKASSA_YOUR_NAME' }}</label>
				{% if reply_name %}{% assign readonly_name = ' readonly' %}{% endif %}
				<input type="text" id="reviewReportName" name="reviewName" value="{{ reply_name }}"{{ readonly_name }}>
				<label for="reviewReportEmail">{{ '_' | jtext: 'COM_JKASSA_YOUR_EMAIL' }}</label>
				{% if reply_email %}{% assign readonly_email = ' readonly' %}{% endif %}
				<input type="email" id="reviewReportEmail" name="reviewEmail" value="{{ reply_email }}"{{ readonly_email }}>
				<span class="help-block"></span>
				<a href="#" class="btn" data-click="send-report" data-id="{{ review_id }}">
					{{ '_' | jtext: 'JSUBMIT' }}
				</a>
				<input type="hidden" name="productID" value="{{ product_id }}">
			</form>
		</div>
		{% endif %}
		<!--Children-->
		{% if children %}
		  {{ children }}
		{% endif %}
	</div>
</div>