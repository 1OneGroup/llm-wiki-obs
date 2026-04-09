---
description: Fetch trending topics in India relevant to real estate, filter for content opportunities
---

Fetch trending topics from Google Trends RSS for India and analyze them for real estate content opportunities.

## Steps

1. Fetch Google Trends RSS:
   - URL: `https://trends.google.com/trending/rss?geo=IN`
   - Parse the XML response to extract trending topics
   - Also try: `https://trends.google.com/trending/rss?geo=IN-PB` (Punjab) and `https://trends.google.com/trending/rss?geo=IN-HR` (Haryana)

2. Filter for real estate relevance:
   - **Direct hits:** property, real estate, apartments, flats, builder, RERA, home loan, EMI, possession
   - **Indirect hits:** infrastructure (metro, highway, airport, expressway), budget (GST, RBI rate), city growth (Mohali, Gurugram, Chandigarh, Tricity)
   - **Festival/occasion:** any upcoming festival, national day, or cultural event

3. Output a structured report:

```
## Trending Report — [date]

### Direct Real Estate Trends
[list with brief context]

### Infrastructure & City Growth
[list with brief context]

### Festival & Cultural Hooks
[upcoming festivals in next 14 days from wiki/social-media/content-strategy.md]

### Content Opportunities
[3-5 specific post ideas based on trends + One Group projects]
```

4. Save output to: `Marketing Department/working/trending-[YYYY-MM-DD].md`

## Usage
Run this before any research node or content planning session.
Invoke: `/trending`
