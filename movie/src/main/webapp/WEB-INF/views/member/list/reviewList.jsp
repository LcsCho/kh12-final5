<script id="review-template" type="text/template">
	<div class="card mt-3">
		<div class="card-body">
			<div>
				<img src="images/user.png" class="userImage">
				<span class="card-title ms-3 memberNickname" style="font-weight: bold; font-size: 20px;"></span>
				<i class="fa-solid fa-star"></i><span class="ratingScore"></span>
			</div>
			<div class="mt-3 pb-3">
				<span class="card-text reviewContent"></span>
			</div>
			<hr>
			<div class="row text-center">
				<div class="col">
					<button type="button" class="btn btn-primary btn-link likeButton" data-reviewNo="">
						<i class="fa-regular fa-thumbs-up"><span class="likeCount"></span></i>
					</button>
				</div>
				<div class="col">
					<a class="commnetButton">					
						<button type="button" class="btn btn-primary btn-link replyButton">
							<i class="fa-regular fa-comment"><span class="replyCount"></span></i>
						</button>
					</a>
				</div>
			</div>
		</div>
	</div>
</script>