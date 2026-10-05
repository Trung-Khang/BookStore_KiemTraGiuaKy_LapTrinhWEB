package com.kiemtragiuaky.util;

import org.mindrot.jbcrypt.BCrypt;

public final class PasswordUtil_24133028 {
    private PasswordUtil_24133028() { }
    public static String hash(String password) { return BCrypt.hashpw(password, BCrypt.gensalt(12)); }
    public static boolean matches(String password, String hash) {
        try { return hash != null && BCrypt.checkpw(password, hash); }
        catch (IllegalArgumentException exception) { return false; }
    }
}
