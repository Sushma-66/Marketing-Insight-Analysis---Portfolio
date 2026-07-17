# Day 3 — Segmentation, Campaign Analysis & Customer Journey
**Marketing & Insight Analyst Portfolio | Building Materials Distributor (sample data)**


## 1. Customer Segmentation — What the RFM Model Shows

Using Recency (days since last order), Frequency (lifetime order count), and
Monetary (lifetime spend), customers fall into four segments:

| Segment | Definition | What it means commercially |
|---|---|---|
| **Champion** | Ordered in last 90 days, 10+ lifetime orders | Highest-value, most active accounts — protect and reward these |
| **Loyal** | Ordered in last 180 days, 5+ lifetime orders | Reliable base, not yet maximised — good upsell target |
| **Developing** | Everyone else with at least 1 order | New or infrequent — needs nurturing to become Loyal |
| **At Risk / Dormant** | No order in 365+ days | Was active once, has gone quiet — win-back candidate |

**Key insight to lead with:** Champions are a small % of the customer base but
disproportionately drive revenue — this is the classic 80/20 pattern. The
commercial risk isn't acquiring more customers, it's **protecting Champions from
churning to a competitor** and **converting Loyal into Champion** through
targeted account management rather than generic campaigns.

**Recommendation:** Champions shouldn't receive the same blanket promotional
emails as Retail — they should get a named account manager check-in and early
access to stock/pricing, not a discount code. Discounting a Champion is often
margin given away for free, since they were going to buy anyway.

---

## 2. Campaign Channel Effectiveness

From the campaign ROI analysis (`Summary_CampaignROI` in Excel):

- **Direct Mail** outperformed digital channels on ROI in this sample — counter
  to the usual assumption that digital is always cheaper/better. For a trade
  and contractor audience, a physical mailer (e.g. a catalogue insert or site
  discount voucher) may simply cut through better than an email that gets lost
  in a busy inbox.
- **Email and SMS campaigns with 0 conversions** show -100% ROI — this doesn't
  necessarily mean the channel is bad, it may mean the **targeting or offer**
  was mismatched to that segment. This is the kind of finding you'd take back
  to a stakeholder as a question, not a verdict: *"Was this campaign timed
  against a promotion contractors were actually likely to need right then?"*

**Recommendation:** Before scaling any channel, run a small controlled test
(same message, same segment, Email vs SMS vs Direct Mail on a matched sample)
rather than assuming last quarter's channel mix is still the right one.

---

## 3. Customer Journey Mapping — New Account Onboarding

Mapping a new Trade Account's likely first 12 months, and where personalisation
and loyalty touchpoints should sit:

| Stage | Timing | Opportunity |
|---|---|---|
| **Signup** | Day 0 | Welcome series (already exists in campaign data) — set expectations on trade pricing, account manager contact, delivery lead times |
| **First order** | Week 1–4 | This is the highest-risk drop-off point — if the first order experience is poor (wrong delivery, confusing invoice), the account may never return. Flag first-order customers for a manual quality check |
| **Repeat purchase window** | Month 2–4 | This is where "Developing" segment customers either become "Loyal" or go quiet. A light-touch check-in (not a sales pitch) at this point can meaningfully lift retention |
| **Loyalty/rewards eligibility** | Month 6+ | Once a customer has enough order history to qualify as Loyal, this is the natural point to introduce a loyalty programme, not before — offering it too early makes it feel like a generic discount rather than an earned reward |
| **At-risk trigger** | 180+ days since last order | Automated re-engagement campaign, ideally referencing their past purchase categories (e.g. "still working on that landscaping job?") rather than a generic "we miss you" |

**Recommendation:** Build the "first order" quality check as a manual or
semi-automated flag (e.g. an ops team member reviews any first order over a
certain value) — this is a low-cost intervention at the highest-leverage point
in the journey.

---

## 4. Summary 

1. Revenue is concentrated in a small Champion segment — retention here matters
   more than acquisition volume.
2. Direct Mail is quietly outperforming digital on ROI for this audience —
   worth testing further rather than defaulting to email-first.
3. The first-order experience is the highest-risk moment in the customer
   journey and the cheapest place to intervene.

