// Eval usage - major security risk
function executeUserCode(code) {
  eval(code);
}

// Unvalidated redirect
function redirect(url) {
  window.location.href = url;
}

// Hardcoded API keys and secrets
const API_KEY = "sk-abc123xyz789";
const DATABASE_URL = "postgresql://user:password123@db.example.com:5432/prod_db";
const AWS_SECRET = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY";

// XSS vulnerability - directly setting innerHTML
document.getElementById('content').innerHTML = userInput;

// Insecure dependency versions
// package.json would have vulnerable versions

// DOM-based XSS
const searchParam = new URLSearchParams(window.location.search);
document.body.innerHTML += '<p>' + searchParam.get('search') + '</p>';

// No Content Security Policy
// Missing security headers

// Weak password validation
function validatePassword(pwd) {
  return pwd.length > 1;
}

// Using var instead of const/let
var globalState = {};

// No error handling
fetch('/api/data').then(r => r.json()).then(d => console.log(d));

// Storing sensitive data in localStorage
localStorage.setItem('authToken', 'super_secret_token_12345');
localStorage.setItem('userPassword', userPassword);

// Insecure regex (ReDoS potential)
const regex = /^(a+)+$/;
regex.test('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaab');

intent bs code
#try meeeee
