---
name: product-research
description: Product research and business understanding. Use for systematic research before launching a new business or product: market research (size, trends, PEST), competitive analysis, metric breakdown (North Star metric decomposition), business model analysis (Wei-Zhu business model, 魏朱六要素 / six-element model), product research (needs met, user groups, historical related products, differentiation and advantages, essence), and market channel analysis (channel selection and channel user characteristics). Use when the user mentions "product research", "market research", "competitor analysis", "business model", "Wei-Zhu model", "new business research", "metric breakdown", or "channel analysis".
---

# Product Research

Goal: understand a **new business / new product** thoroughly in the shortest possible time: what market it is in, whose problem it solves, why it will win, how it makes money, where customers come from, and which metrics measure it.

## Workflow

Confirm the inputs first, work through the modules in order, and finish with a structured research report.

### 0. Define the research scope (must be confirmed before starting)

Confirm with the user, or infer from context:
- Research subject: a specific product / business direction / sector
- Research purpose: go/no-go decision, competitor benchmarking, fundraising materials, iteration direction, market-entry assessment
- Geography and time range: domestic/overseas, last 1 / 3 / 5 years
- Existing materials: internal data, interview notes, industry reports
- Output depth: quick scan (one-page conclusion) or full report

When information is insufficient, ask only the key questions, proceed on reasonable assumptions for the rest, and **state the assumptions explicitly** in the report.

You may use WebSearch / WebFetch to obtain public data (industry reports, financial reports, prospectuses, app store data, news, user reviews). **Cite the source and date** for all data, state the estimation method for derived figures, and mark anything that cannot be verified as "To be verified".

---

### 1. Business understanding

State the business in one sentence: **For [whom], in [what scenario], solving [what problem], earning revenue through [what means].**

Then answer:
- Position in the value chain (upstream/midstream/downstream; B2B, B2C, or B2B2C)
- Whether it is a new business (0→1), an expansion business (1→N), or a transformation business
- The company's motive for pursuing this business: defense, growth, synergy, strategic positioning
- Key assumptions list: the 3–5 assumptions that must be true for this business to work

### 2. Market research

| Dimension | Question to answer | Common methods |
|---|---|---|
| Market size | How large are TAM / SAM / SOM | Top-down (industry reports) + bottom-up (users × penetration × average order value × frequency); cross-check the two results |
| Growth trend | Growth rate and lifecycle stage (introduction/growth/maturity/decline) | Historical data, search indexes, funding events |
| Macro environment | Drivers and constraints from policy, economy, society, and technology (PEST) | Policy documents, technology maturity |
| Industry chain | Who is upstream and downstream, and where profit is concentrated | Industry chain map |
| Drivers | Why "now" (Why now) | Technology inflection points, policy windows, shifts in user habits |
| Risks | Regulation, technology, false-demand premise, entry of giants | Risk matrix (probability × impact) |

### 3. Competitive analysis

1. **Competitive landscape**: List direct competitors, indirect competitors, potential entrants, and substitutes (including "users use nothing / solve it by hand"). Assess market concentration (CR3/CR5).
2. **Competitor comparison table**:

   | Dimension | This product | Competitor A | Competitor B | Substitute |
   |---|---|---|---|---|
   | Target users | | | | |
   | Core features | | | | |
   | Pricing / monetization | | | | |
   | Acquisition channels | | | | |
   | Scale data (users / revenue / funding) | | | | |
   | Strengths | | | | |
   | Weaknesses | | | | |

3. **Porter's Five Forces**: supplier bargaining power, buyer bargaining power, threat of new entrants, threat of substitutes, intensity of rivalry within the industry.
4. **SWOT**: Summarize from the conclusions above; do not list items out of thin air.
5. **Moat assessment**: network effects / economies of scale / switching costs / brand / data / licenses and resources. Which does this product have, and can it build them?

### 4. Metric breakdown

1. Determine the **North Star metric**: the single metric that best reflects users getting core value and is strongly correlated with business revenue.
2. Break it down layer by layer into an actionable metric tree, for example:

   ```
   GMV = visiting users × conversion rate × average order value
       visiting users = new users (acquired through each channel) + returning users (retention × activity frequency)
       conversion rate = browse→add-to-cart × add-to-cart→order × order→payment
       average order value = price per item × items per order
   ```

3. For each leaf metric, note: current value / industry benchmark, owning team, and available levers for improvement.
4. Add a **unit economics model**: CAC, LTV, LTV/CAC (healthy line is usually >3), payback period, gross margin, contribution profit.
5. Use AARRR (Acquisition-Activation-Retention-Revenue-Referral) to check for missing stages.

### 5. Business model analysis (Wei-Zhu six-element model)

See [references/weizhu-business-model.md](references/weizhu-business-model.md) for details. Analyze the six elements in order:

1. **Positioning**: what needs of stakeholders are met, and in what way
2. **Business system**: who the stakeholders are, their respective roles and transaction relationships (draw a transaction structure diagram)
3. **Key resources and capabilities**: the core resources and capabilities that make the business system run
4. **Profit model**: revenue sources and cost structure, and the payment methods (fixed / residual / revenue share / time-based / usage-based, etc.)
5. **Cash flow structure**: the timing of cash inflows and outflows, whether payment is collected in advance, whether the model is asset-heavy
6. **Enterprise value**: investment value = discounted future free cash flow; focus on growth potential, capability, and efficiency

You may add the Business Model Canvas (9 blocks) as a cross-check.

### 6. Product research

For the target product (your own or a competitor's), answer each of the following:

- **Needs met**: What is the user's real job (Jobs-to-be-Done)? Is it a must-have / high-frequency / pain point, or merely nice-to-have? Evaluate with "need intensity × frequency × willingness to pay".
- **User groups**: core users, secondary users, whether payers and users are separate; user scale and distribution. (Detailed personas are handled by the `user-communication` skill.)
- **Historical related products**: How was this need met in the past? List predecessor products / failure cases / a timeline of similar products, and summarize why they succeeded or failed: "Why didn't it work before, and why can it now?"
- **Differentiation and advantages**: Compared with existing solutions, on which of experience / efficiency / cost / coverage is it significantly better (ideally 10x rather than 10%)? Can the differentiation be copied quickly?
- **Essence**: Strip away the surface features. What is this product at its core? (Example: food delivery is essentially "local supply-demand matching with instant fulfillment"; short video is essentially "algorithm-driven attention distribution".) Express it with the pattern "It is essentially using [resource/capability] to reduce [what cost] / improve [what efficiency]".

### 7. Market channels

- **Channel inventory**: online (app stores, search SEM/SEO, feed ads, social media, content platforms, KOLs, communities, private domain, viral referral), offline (field promotion, stores, trade shows, distributors), B2B (direct sales, channel agents, ecosystem partnerships, tenders and bidding).
- **Which channels competitors use**: Infer competitors' channel playbook from ad platforms, app store rankings, content platform accounts, job postings, etc.
- **What the channel users are like**: user persona, scale, acquisition cost, conversion rate, and retention quality for each channel.

  | Channel | User characteristics | Scale | CAC | Conversion rate | Retention / quality | Fit with target users |
  |---|---|---|---|---|---|---|

- **Channel strategy recommendations**: which 1–2 channels to saturate during the cold-start stage; how to combine them at the scaling stage; which channels are competitors' weak points.

---

## Output format

By default, output a Markdown research report with the structure below (in quick-scan mode, output only Section 1 plus 3 bullet points per module):

```markdown
# [Product/Business Name] Research Report

## 1. Core Conclusions (One-Pager)
- One-sentence business definition
- Worth pursuing or not + key reasons (3)
- Biggest risks (3)
- Recommended next steps

## 2. Business Understanding and Key Assumptions
## 3. Market Research
## 4. Competitive Analysis
## 5. Metric Breakdown
## 6. Business Model (Wei-Zhu Six Elements)
## 7. Product Research (Needs / User Groups / Historical Products / Differentiation and Advantages / Essence)
## 8. Market Channels
## 9. Open Questions to Verify (for User Interviews / Data Validation)
## Appendix: Data Sources
```

The "Open Questions to Verify" list in Section 9 should be directly usable by the `user-communication` skill to design interview outlines.

## Principles

- **Conclusion first**: in each module, give the conclusion first, then the supporting evidence.
- **Let data speak**: where there is a number, skip the adjective; all data must have a source.
- **Distinguish fact, inference, and assumption**: label each separately.
- **Find the essence, don't just enumerate**: don't pile on frameworks; a framework is only a tool to check for omissions.
- **Stay critical**: actively look for counter-evidence and point out cases where the need may be a false need.
