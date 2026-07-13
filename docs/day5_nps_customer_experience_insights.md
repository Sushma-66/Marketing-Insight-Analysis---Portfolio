# Day 5 — NPS & Customer Experience Insight
**Marketing & Insight Analyst Portfolio | Building Materials Distributor (sample data)**

---

## 1. What the NPS Data Shows

NPS Score = % Promoters (9–10) − % Detractors (0–6), calculated per branch
(see `Summary` query 5 in `02_business_analysis.sql`).

**How to read this, not just report it:**
- A branch with a *high* NPS but *low* order volume might be doing well on
  service but has an untapped growth opportunity — worth asking why volume
  is low if satisfaction is high.
- A branch with *low* NPS and *high* volume is the bigger commercial risk —
  you're pushing volume through a customer experience that's actively
  generating Detractors, which tends to show up later as churn.

**Recommendation:** Don't rank branches on NPS alone — cross it with revenue
and repeat-purchase rate. The branch that needs attention first is the one
that's high-volume AND low-NPS, not just the lowest score on the list.

---

## 2. Segment Cross-Reference

Cross-referencing NPS category (Promoter/Passive/Detractor) against customer
type gives a sharper read than branch alone:

- If **Contractors** skew more Detractor than **Retail**, that's a signal
  about trade-specific pain points (e.g. delivery timing on a job site is
  more failure-prone than a retail pickup) — worth a follow-up qualitative
  question in the next survey wave, not just a repeat of the same 0-10 score.
- If **Champions** (from the RFM segmentation) include Detractors, that's a
  priority flag — a high-value customer who is also unhappy is the highest-risk
  churn case in the entire dataset and should trigger a direct outreach, not
  wait for the next scheduled survey.

---

## 3. Recommendations (the part a hiring manager actually wants to see)

1. **Prioritise by value, not just volume of complaints.** Build a simple flag:
   Detractor + Champion/Loyal segment = immediate account manager follow-up.
   This turns a passive survey into an active retention tool.
2. **Investigate the delivery/first-order experience specifically for
   Contractors**, since trade customers are more time/site-dependent than
   retail — a late delivery has a bigger downstream cost for them (a stalled
   job) than for a retail customer buying for a weekend project.
3. **Close the loop with Promoters, not just Detractors.** Promoters are an
   underused asset — a light "would you refer a colleague" ask, or a case
   study request, turns a good score into referral pipeline rather than just
   a number in a report.

---

## 4. One-Line Executive Summary
*"NPS is healthy overall, but a subset of high-value Contractor accounts are
showing Detractor sentiment — closing that gap is a higher-leverage priority
than raising the average score by another point."*

(This is the sentence you'd actually say out loud in a stakeholder meeting —
practice saying it without reading it.)
