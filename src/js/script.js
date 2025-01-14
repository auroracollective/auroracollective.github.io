document.addEventListener('DOMContentLoaded', () => {
  const toggleButton = document.querySelector('.toggle-button');
  const closeButton = document.querySelector('.close-button');
  const mobileMenu = document.querySelector('.mobile-menu');
  const navbarLinks = document.querySelector('.navbar-links');

  toggleButton.addEventListener('click', () => {
    mobileMenu.classList.toggle('active');
    navbarLinks.classList.toggle('active');
  });

  closeButton.addEventListener('click', () => {
    mobileMenu.classList.remove('active');
    navbarLinks.classList.remove('active');
  });

  showSlide(currentSlide);
  setInterval(nextSlide, 3000); // Change slide every 3 seconds
});

let currentSlide = 0;

function showSlide(index) {
  const slides = document.querySelectorAll('.carousel-item');
  if (index >= slides.length) {
    currentSlide = 0;
  } else if (index < 0) {
    currentSlide = slides.length - 1;
  } else {
    currentSlide = index;
  }
  const offset = -currentSlide * 100;
  document.querySelector('.carousel-inner').style.transform = `translateX(${offset}%)`;
}

function nextSlide() {
  showSlide(currentSlide + 1);
}