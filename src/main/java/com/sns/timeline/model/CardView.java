package com.sns.timeline.model;

import java.util.List;

import com.sns.comment.model.Comment;
import com.sns.comment.model.CommentView;
import com.sns.post.model.Post;
import com.sns.user.model.User;

public class CardView {

	private Post post;

	private User user;

	private List<CommentView> commentList;

	public List<CommentView> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<CommentView> commentList) {
		this.commentList = commentList;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

}
