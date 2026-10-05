package com.kiemtragiuaky.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "users")
public class User_24133028 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "email", nullable = false, unique = true, length = 50)
    private String email;

    @Column(name = "fullname", length = 50)
    private String fullname;

    @Column(name = "phone")
    private Integer phone;

    @Column(name = "passwd", nullable = false, length = 100)
    private String password;

    @Column(name = "signup_date")
    private LocalDateTime signupDate;

    @Column(name = "last_login")
    private LocalDateTime lastLogin;

    @Column(name = "is_admin")
    private Boolean admin = Boolean.FALSE;

    @Column(name = "email_verified", nullable = false)
    private Boolean emailVerified = Boolean.FALSE;

    @OneToMany(mappedBy = "user", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    private Set<Rating_24133028> ratings = new LinkedHashSet<>();

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public Integer getPhone() { return phone; }
    public void setPhone(Integer phone) { this.phone = phone; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public LocalDateTime getSignupDate() { return signupDate; }
    public void setSignupDate(LocalDateTime signupDate) { this.signupDate = signupDate; }
    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }
    public Boolean getAdmin() { return admin; }
    public boolean isAdmin() { return Boolean.TRUE.equals(admin); }
    public void setAdmin(Boolean admin) { this.admin = admin; }
    public Boolean getEmailVerified() { return emailVerified; }
    public boolean isEmailVerified() { return Boolean.TRUE.equals(emailVerified); }
    public void setEmailVerified(Boolean emailVerified) { this.emailVerified = emailVerified; }
    public Set<Rating_24133028> getRatings() { return ratings; }
    public void setRatings(Set<Rating_24133028> ratings) { this.ratings = ratings; }
}
