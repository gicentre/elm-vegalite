# V1.12 ➡ V2.0

Major release supporting Vega-Lite 4.0. Includes a small number of breaking changes that should provide greater flexibility and some simplification of the API.

- TODO: **default** setting for lookup, and possibly more flexable `as` naming to allow lists of names.

## Breaking Changes

- _`title` now takes a list of optional title properties._
  To update older code, simply add a `[]` as a second parameter to `title`
- _`axValues` now takes `DataValues` (allowing numbers, strings, dates and Booleans) rather than just a list of floats._
  To update older code, replace `axValues [1,2,3] with axValues (nums [1,2,3])`.
- _Removed (invalid) functions `mImpute` and `dImpute`._
- `opArgMin` and `opArgMax` now require a `Maybe String` parameter.
  To update older code, replace `opArgMin` with `opArgMin Nothing`.
- _Overlap strategy constuctors hidden._
  Should use `osNone`, `osGreedy` and `osParity` instead. These were always available, but the constructors themselves had been inadvertantly exposed, so it is unlikely to require a change in practice.
- _`lookup` now uses the `Data` type alias as part of its type signature._
  This is unlikely to impact any use of the API but is technically a breaking change.
- _`columns` now takes an `int` rather than `Maybe int`._
  To update older code, replace `columns (Just n)` with `columns n` and `columns Nothing` with `columns 0`.

## Additions

- Convenience functions for setting a channel's measurement type. `pNominal`, `pOrdinal`, `pQuant`, `pTemporal` and `pGeo` equivalent to `pMType Nominal`, `pMType Ordinal` etc. Similar functions for `m` (mark), `t` (text), `h` (hyperlink), `o` (order) `d` (detail) and `f` (facet) channels.
- `pivot` (and associated `pi` pivot property functions) for data shaping.
- `regression` (and associated `rg` regression property functions) for regression modelling.
- `density` (and associated `dn` density property functions) for KDE transforms.
- `loess` (and associated `ls` loess property functions) for locally-estimated scatterplot smoothing.
- `maColorGradient`, `maFillGradient` and `maStrokeGradient` (and associated `gr` gradient property functions) for gradient-based colouring.
- `mSort` for sorting by mark properties like `color`.
- `axDataCondition` and associated `cAx` property functions for conditional axis formatting.
- Additional axis formatting options: `axGridColor`, `axGridOpacity`, `axGridWidth`, `axLabelExpr`, `axLabelFontStyle`, `axTitleFontStyle` and `axTitleAnchor` along with extra config options `axcoLabelFontStyle`, `axcoTitleFontStyle` and `axcoTitleAnchor`.
- New title configuration options: `ticoFontStyle`, `ticoFrame`, `ticoStyle` and `ticoZIndex`.
- `vicoStep` for configuring default step size for discrete x and y discrete fields.
- `coConcat` for configuring concatenations (`cocoSpacing` and `cocoColumns`).
- `fiOp` for converting filters into `BooleanOp` and therefore allowing Boolean composition of filter functions.
- `fiOpTrans` for combining an inline data transformation with a filter and converting to a `BooleanOp`. Especially useful when filtering temporal data that require aggregating with `mTimeUnit`.
- `maWidth` and `maHeight` for explicitly setting mark width and height.
- `scAlign` for aligning marks within a range.
- `noData` for preventing inheritance of parent data source in a specfication.
- `nullValue` for explicitly setting data values to null.
- `widthStep` and `heightStep` for setting the width/height of a discrete x or y field (e.g. individual bars in a bar chart).
- `seInitInterval` for initialising an interval selection's extent.

## Deprecations

- `axDates` deprecated in favour of new more flexible `axValues`.
- `scReverse` deprecated in favour of `mSort` (while `scReverse` works, it is not part of the Vega-Lite schema).
- `scRangeStep`, deprecated in favour of `widthStep` and `heightStep`.
- `sacoRangeStep` and `sacoTextXRangeStep` deprecated in favour of `vicoStep`.

## Bug Fixes

- `coFieldTitle` now correctly creates a 'functional' label.
- Overlap strategy `osNone` now evaluates correctly.
- Empty grid/stroke dash list now correctly generates a `null` value rather than empty array in JSON spec (while an empty array works, it is not permitted by the Vega-Lite schema).

## Other Changes

- Improvements to the API documentation with a larger number of inline examples.
- New gallery examples reflecting addtions to the Vega-Lite example set.
- Numerous minor gallery example updates to reflect API changes and provide more idiomatic specifications.
