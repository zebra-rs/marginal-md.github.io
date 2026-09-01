---
title: Account and subscription
description: The trial, signing in, what a subscription covers, and what read-only means.
sidebar: { order: 3 }
---

Marginal is a subscription: $10 a month or $96 a year, one plan. The first
sign-in starts a 14-day trial of the full app, with no card. Everything on
this page lives in **Settings ▸ Account**, also reachable as **Account…**
in the app menu and the command palette, and by clicking the licence chip
in the status bar.

## What the subscription covers

Editing. Reading, preview, printing, and export always work, signed in or
not. If a subscription lapses, Marginal turns read-only: your files are
never locked, and a document you changed while you were licensed can still
be saved.

The AI features are separate. They run on
[your own Anthropic key](../../ai/setup/) and are never gated by the
subscription.

## Signing in

Click **Sign in…** and finish in the browser with Google or GitHub.
Marginal picks the result up automatically. If the hand-off from the
browser does not reach the app, **Sign in with a code** shows a code in the
browser to paste into Settings instead.

**Sign out** ends the session on this device and in your browser, so the
next sign-in asks which account to use.

## Subscribing

**Subscribe** offers the monthly and yearly plans and opens Stripe Checkout
in the browser; Marginal picks the purchase up when it completes.
**Manage subscription…** opens the Stripe customer portal for invoices,
card changes, and cancellation.

If a payment fails, the status shows *Payment issue* and editing keeps
working for a few days while you update the card; after that the app is
read-only until the payment goes through.

## Status

The **Status** line, and the chip in the status bar, tell you where you
stand:

| Status | Meaning |
|---|---|
| Trial — N days left | The trial is running |
| Monthly, Yearly, Complimentary | The subscription is active, with its renewal or end date |
| Payment issue | A payment failed; editing continues for a few days |
| Clock changed, Licence check failed | Marginal could not confirm the licence; **Refresh now** retries online |
| No active subscription, Signed out, Not signed in | Read-only |

The licence is checked against the server once a day in the background. A
network failure changes nothing; only a refusal from the server ends the
session.

## Devices

**Devices (N of M)** lists the devices signed in to your account and how
many the plan allows. **Rename** gives a device a name you recognise;
**Deactivate** frees a seat taken by a device you no longer use.

## Deleting your account

**Delete my account…** asks you to type `DELETE`. It cancels the
subscription, signs out every device, and removes the account from
Marginal's servers and from the sign-in provider. Payment records stay with
Stripe. Your files are not touched.
