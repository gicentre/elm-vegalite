# Vega Lite Changes

## Pending changes

### Additions

- `miLinearClosed` interpolation to form closed polygons (missed exposing this from earlier releases).

---

## V2.0.0 ➡ V2.1.0

### Additions

- `naturalEarth1` map projection type.

### Bug Fixes

- Correct `maxsteps` parameter output of `density` transform (thanks @dougburke for spotting this).
- Correct but in `density` that was incorrectly using value of `dnCounts` for the `dnCumulative` setting (thanks @dougburke for spotting this).

---

## V1.12 ➡ V2.0

Major release supporting Vega-Lite 4.0. Includes a small number of breaking changes that should provide greater flexibility and some simplification of the API.

### Breaking Changes

- _`title` now takes a list of optional title properties._
  To update older code, simply add a `[]` as a second parameter to `title`

* _`lookup` now allows naming of individual matched fields and a default for failed lookups_.
  Instead of `lookup "key1" secondaryData "key2" ["field1", "field2"]` use `lookup "key1" secondaryData "key2" (luFields ["field1", "field2"])`. Additional functions `luAs`, `luAsWithDefault`, `luFieldsAs`, `luFieldsAsWithDefault`, `luFields` and `luFieldsWithDefault` provide greater flexibility in naming and default behaviour. It also uses the `Data` type alias as part of its type signature, which is unlikely to impact any use of the API but is technically a breaking change.

- _Replaced `coRemoveInvalid` with `maRemoveInvalid`_.
  To stop filtering of invalid values, this is now specified as a mark property. For example, instead of `configuration (coRemoveInvalid False)`, use `configuration (coMark [ maRemoveInvalid False ])`.

* _Tooltips are now disabled by default_ (via change in Vega-lite).
  Can be enabled either via an explicit `tooltip` channel, or by setting `maTooltip ttEncoding`.

- _Background is now white by default_ (via a change in Vega-lite).
  Previously backgrounds were transparent. Can mimic previous behaviour by adding a transparent configuration `configuration (coBackground "rgba(0,0,0,0)")`

* _`axValues` now takes `DataValues` (allowing numbers, strings, dates and Booleans) rather than just a list of floats._
  To update older code, replace `axValues [1,2,3] with axValues (nums [1,2,3])`.

- _Removed (invalid) functions `mImpute` and `dImpute`._

* _`opArgMin` and `opArgMax` now require a `Maybe String` parameter._
  To update older code, replace `opArgMin` with `opArgMin Nothing`.

- _Overlap strategy constructors hidden._
  Should use `osNone`, `osGreedy` and `osParity` instead. These were always available, but the constructors themselves had been inadvertently exposed, so it is unlikely to require a change in practice.

* _`columns` now takes an `int` rather than `Maybe int`._
  To update older code, replace `columns (Just n)` with `columns n` and `columns Nothing` with `columns 0`.

- `Position` custom type has extra variants `XError`, `XError2`, `YError` and `YError2`. Technically a breaking change but unlikely to affect existing specifications unless pattern matching against `Position`.

### Additions

#### Transforms

- `density` (and associated `dn` density property functions) for KDE transforms.

* `loess` (and associated `ls` loess property functions) for locally-estimated scatterplot smoothing.

- `pivot` (and associated `pi` pivot property functions) for data shaping.

* `quantile` (and associated `qt` quantile property functions) for computing quantiles from a distribution.

- `regression` (and associated `rg` regression property functions) for regression modelling.

* `fiOp` for converting filters into `BooleanOp` and therefore allowing Boolean composition of filter functions.

- `fiOpTrans` for combining an inline data transformation with a filter and converting to a `BooleanOp`. Especially useful when filtering temporal data that require aggregating with `mTimeUnit`.

#### Marks and Mark Properties

- `image` mark and associated `url` channel and `maAspect` mark property for displaying images.

* `mSort` for sorting by mark properties like `color`.

- `maColorGradient`, `maFillGradient` and `maStrokeGradient` (and associated `gr` gradient property functions) for gradient-based colouring.

* `maCornerRadius`, `maCornerRadiusBottomLeft`, `maCornerRadiusBottomRight`, `maCornerRadiusTopLeft` and `maCornerRadiusTopRight` for rounding a rectangle mark.

- `maWidth` and `maHeight` for explicitly setting mark width and height.

* `pBand` for setting position/size relative to a band width.

- Support empty strings for `maFill` and `maStroke` to indicate absence of fill or stroke.

#### Selections

- `lookupSelection` for lookups that rely on an interactive selection of data.

* `seBindLegend` and associated property functions `blField`, `blChannel` and `blEvent` for creating interactive legends.

- `seInitInterval` for initialising an interval selection's extent.

* `biSelectionExtent` for basing a bin extent on an interactive selection.

#### Configuration

- New title configuration options: `ticoFontStyle`, `ticoFrame`, `ticoStyle`, `ticoZIndex`, `ticoSubtitleColor`, `ticoSubtitleFont`, `ticoSubtitleFontSize`, `ticoSubtitleFontStyle`, `ticoSubtitleFontWeight`, `ticoSubtitleLineHeight` and `ticoSubtitlePadding`.

* `coConcat` for configuring concatenations (`cocoSpacing` and `cocoColumns`).

- `vicoStep` for configuring default step size for discrete x and y discrete fields.

* `vicoContinuousWidth`, `vicoDiscreteWidth`, `vicoContinuousHeight` and `vicoDiscreteHeight` for dimension configuration depending on type of data.

- `vicoBackground` for configuring default single view plot area background appearance.

#### Titles and Axes

- `title` and component titles (axis title, legend title etc.) can now be formatted over multiple lines with `\n` or `"""` multi-line strings.

* `axDataCondition` and associated `cAx` property functions for conditional axis formatting.

- Additional axis formatting options: `axGridColor`, `axGridOpacity`, `axGridWidth`, `axLabelExpr`, `axLabelFontStyle`, `axLabelSeparation`, `axTitleFontStyle` and `axTitleAnchor` along with extra config options `axcoLabelFontStyle`, `axcoLabelSeparation`, `axcoTitleFontStyle` and `axcoTitleAnchor`.

* New title option `tiSubtitle` for specifying secondary title text. Can be styled via new functions `tiSubtitleColor`, `tiSubtitleFont`, `tiSubtitleFontSize`, `tiSubtitleFontStyle`, `tiSubtitleFontWeight`, `tiSubtitleLineHeight` and `tiSubtitlePadding`.

#### Data

- `noData` for preventing inheritance of parent data source in a specification.

* `nullValue` for explicitly setting data values to null.

- `dtMonthNum` for referencing a month by its numeric value.

* `tStr` for string literals in a text encoding channel.

#### Other

- Convenience functions for setting a channel's measurement type. `pNominal`, `pOrdinal`, `pQuant`, `pTemporal` and `pGeo` equivalent to `pMType Nominal`, `pMType Ordinal` etc. Similar functions for `m` (mark), `t` (text), `h` (hyperlink), `o` (order) `d` (detail) and `f` (facet) channels.

* `scAlign` for aligning marks within a range.

- `widthStep` and `heightStep` for setting the width/height of a discrete x or y field (e.g. individual bars in a bar chart).

* `widthOfContainer` and `heightOfContainer` for responsive sizing.

- `asFitX` and `asFitY` for autosizing in one dimension only.

* Additional symbols `symTriangleLeft`, `symTriangleRight`, `symTriangle`, `symArrow`, `symWedge` and `symStroke` and `mSymbol` convenience function for symbol literals.

- `equalEarth` map projection type.

* `key` channel for binding with Vega View API.

### Deprecations

- `axcoShortTimeLabels` deprecated as this is the default since VL4.

* `axDates` deprecated in favour of new more flexible `axValues`.

- `lookupAs` deprecated in favour of `lookup` with `luAs`.

* `scReverse` deprecated in favour of `mSort` (while `scReverse` works, it is not part of the Vega-Lite schema).

- `scRangeStep`, deprecated in favour of `widthStep` and `heightStep`.

* `sacoRangeStep` and `sacoTextXRangeStep` deprecated in favour of `vicoStep`.

- `vicoWidth` and `vicoHeight` deprecated in favour of `vicoContinuousWidth`, `vicoDiscreteWidth`, `vicoContinuousHeight` and `vicoDiscreteHeight`.

* `coStack` deprecated as it is unecessary.

### Bug Fixes

- `coFieldTitle` now correctly creates a 'functional' label.

* Overlap strategy `osNone` now evaluates correctly.

- Field definitions inside `mDataCondition` now handled correctly (previously only worked with value definitions).

* Empty grid/stroke dash list now correctly generates a `null` value rather than empty array in JSON spec (while an empty array works, it is not permitted by the Vega-Lite schema).

### Other Changes

- Improvements to the API documentation with a larger number of inline examples.

* New gallery examples reflecting additions to the Vega-Lite example set.

- Numerous minor gallery example updates to reflect API changes and provide more idiomatic specifications.

* Additional tests for new functionality.
