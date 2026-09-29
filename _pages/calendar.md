---
layout: page
permalink: /calendar/
title: calendar
description: Información de las fotos para el calendario del 2027
nav: true
nav_order: 6
---

¡Gracias por comprar un calendario! En cada mes, van a poder encontrar información sobre la foto, la especie y más.

<!-- _pages/calendar.md -->
{% assign months = site.calendar | sort: "month" %}

<div class="calendar">
  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3">
    {% for month in months %}
      {% include calendar_card.liquid month=month %}
    {% endfor %}
  </div>
</div>
