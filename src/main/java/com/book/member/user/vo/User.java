package com.book.member.user.vo;

import java.time.LocalDateTime;

public class User extends Paging{
   private int user_no;
   private String user_name;
   private String user_id;
   private String user_pw;
   private String user_email;
   private String user_nickname;
   private int user_active;
   private LocalDateTime user_create;
   
   public User() {
      super();
      
   }
   
   

   public User(int user_no, String user_name, String user_id, String user_pw, String user_email, String user_nickname,
         int user_active, LocalDateTime user_create) {
      super();
      this.user_no = user_no;
      this.user_name = user_name;
      this.user_id = user_id;
      this.user_pw = user_pw;
      this.user_email = user_email;
      this.user_nickname = user_nickname;
      this.user_active = user_active;
      this.user_create = user_create;
   }



   public int getUser_no() {
      return user_no;
   }

   public void setUser_no(int user_no) {
      this.user_no = user_no;
   }

   public String getUser_name() {
      return user_name;
   }

   public void setUser_name(String user_name) {
      this.user_name = user_name;
   }

   public String getUser_id() {
      return user_id;
   }

   public void setUser_id(String user_id) {
      this.user_id = user_id;
   }

   public String getUser_pw() {
      return user_pw;
   }

   public void setUser_pw(String user_pw) {
      this.user_pw = user_pw;
   }

   public String getUser_email() {
      return user_email;
   }

   public void setUser_email(String user_email) {
      this.user_email = user_email;
   }

   public String getUser_nickname() {
      return user_nickname;
   }

   public void setUser_nickname(String user_nickname) {
      this.user_nickname = user_nickname;
   }

   public int getUser_active() {
      return user_active;
   }

   public void setUser_active(int user_active) {
      this.user_active = user_active;
   }

   public LocalDateTime getUser_create() {
      return user_create;
   }

   public void setUser_create(LocalDateTime user_create) {
      this.user_create = user_create;
   }



   @Override
   public String toString() {
      return "User [user_no=" + user_no + ", user_name=" + user_name + ", user_id=" + user_id + ", user_pw=" + user_pw
            + ", user_email=" + user_email + ", user_nickname=" + user_nickname + ", user_active=" + user_active
            + ", user_create=" + user_create + "]";
   }

   
   
}   