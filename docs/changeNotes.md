# elm-vegaLite changes

## Pending Changes

### Additions

- New `maMinBandSize` for configuring the minimum width/height of a bar mark (VL 5.11).

- New `extent` transform (VL 5.10) for storing minimum and maximum values in a data field.

- New option labelling functions `inLabelledOptions`, `inLabelledDatumOptions` and `inLabelledDataOptions` for attaching labels to each option in a radio or drop-down selection. Thanks to @hingew for identifying the need for this.

---

## V5.4.3 ➡ V5.5

- Align with Vega-Lite release 5.9.0. Most changes are bugfixes and enhancements in the Vega-Lite runtime that do not affect the elm-vegalite API.

### V5.5 Additions

- `coTooltipFormat` to allow tooltip-specific formatting of displayed values (VL 5.9)

### API Documentation

- Minor additions to API docs with code examples.

---

## V5.4.0 ➡ V5.4.3

- Minor API doc improvements (v5.4.1 and v5.4.2 similar doc improvements). Thanks to @RalfNorthman for some improvement suggestions and valuable error checking.

---

## V5.3.0 ➡ V5.4.0

### V5.4 Additions

- `fromPosixTime` to allow Elm time functions to be used to generate elm-vegalite `DateTime` values. Thanks to @RalfNorthman for the suggestion.

- `secoZero` to set the default for whether zero is included in the domain of a scale (VL5.6).

### Corrections

- Correct `loGrouping` bug that generated a single locale grouping rather than array. Thanks @hingew for spotting this.

### API Documentation

- Corrected API doc for coLocale example to use correct Elm unicode escape text.

- Added reference to parent functions to some functions in the API docs. This makes it easier to see how a function is used in the context of a larger specification by navigating up the function dependency tree. Thanks to @RalfNorthman for the suggested improvement.

### Deprecations

- Deprecated `dtMonthNum` as it was redundant (use `dtMonth` instead). There should be no reason to allow specification of months with numbers as this carries the risk of undefined behaviour for integers outside the range [1,12]. Thanks to @RalfNorthman for spotting this.

- `AxisChoice`, `axX` and `axY` deprecated as specific axis choice is specified via `coAxisXFilter` and `coAxisYFilter`. These have been redundant since elm-vegalite V2.3.0 but were inadvertently left exposed in the API.

---

## V5.5.2 ➡ V5.3.0

_Minor addition to allow multiple time formats to be specified for an axis._

- Add `axTemporalFormats` to allow multiple time formats for temporal axis labels depending on temporal granularity. Thanks @RalfNorthman for the suggestion.

---

## V5.1.1 ➡ V5.2.0

_Minor changes to allow custom metadata to be added to a specification._

### V5.2 Additions

- Add `userMeta` function for attaching custom metadata objects to a JSON specification. This was part of the VL 5 spec but had been missed in the elm-vegalite implementation.

---

## V5.1.0 ➡ V5.1.1

_Minor changes that add some richer examples to the API documentation._

---

## V5.0.0 ➡ V5.1.0

_Minor changes to accommodate a few additions that appeared in Vega-Lite 5.5 and to update the API docs with richer examples._

### V5.1 Additions

- `coNumberFormatType` and `coNormalizedNumberFormatType` for configuring custom numeric formatting of axis, legend and tooltip numbers (Vega-Lite 5.4) and `coTimeFormatType` for custom temporal formatting (Vega-Lite 5.5).

### Other Changes

- Add number format configuration tests for new Vega-Lite 5.4 and 5.5 number and time formatting configuration options.

- Add many examples to API docs.

---

## V4.0.0 ➡ V5.0.0

_While this is a 'major' release, this is largely to remove deprecated functions that relate to an older Vega-Lite interaction model and to longhand measurement type functions that have had shorthand equivalents for several years. The main addition is to support Vega-Lite's new offset channels for modifying position encoding._

### V5.0 Breaking Changes

- Removed deprecated functions and types:

  - `Binding` and associated functions `iCheckbox`, `iColor`, `iDate`, `iDateTimeLocal`, `iMonth`, `iNumber`, `iRadio`, `iRange`, `iSelect`, `iTel`, `iText`, `iTime`, `iWeek` and `seBind`.
  - `BindLegendProperty` and associated functions `blChannel`, `blEvent`,`blField` and `seBindLegend`
  - `hDataCondition`, `hSelectionCondition`, `mDataCondition`, `mSelectionCondition`, `oDataCondition` and `oSelectionCondition`
  - `pBand`
  - `seBindScales`, `seEmpty`, `seInit`, `seInitInterval`, `seMulti` and `seSingle`
  - `select`, `selection` and `selectionName`.

  These mostly relate to the old interaction model superseded in Vega-Lite 5 / elm-Vegalite 4 (see 'Deprecations' in change document for elm-Vegalite 4 for details on updating any legacy interaction functions that follow the old Vega-Lite interaction model).

- New `Position` types to support Vega-Lite 5.2's new offset channel: `XOffset` and `YOffset`. While technically a breaking change as it extends the `Position` custom type variants, these additions are unlikely to break any existing code.
- Remove exposed `Measurement` type and associated functions `pMType`, `mMType`, `tMType`, `hMType`, `dMType`, `oMType`, `fMType` and `kMType`. Since elm-vegaLite V2, the preferred way to declare a measurement type has been through the more concise functions `pQuant`, `pGeo`, `pTemporal`, `mQuant` etc.

### V5.0 Additions

- Support for the new offset channel (VL 5.2) with `position XOffset` and `position YOffset` along with channel identifiers `chXOffset` and `chYOffset`, useful for grouped bar charts and jitter-plots.

- `widthStepOffset` and `heightStepOffset` for specifying discrete step sizes (e.g. bars) for groups with a common offset. Only has an effect when specification uses a position offset channel (VL 5.2).

- `pRepeatDatum` for use with position offsets and repeated encoding of multiple data fields (VL 5.2).

- `leLabelExpr` for customising legend labels.

### V5.0 Other Changes

- Added further examples to gallery and tests.

---

## V3.1.1 ➡ V4.0.0

_Major changes are the use of expression parameters (limited form of Vega signals) and a new unified parameter/selection model for interaction. Both reflect changes introduced with the major release of Vega-Lite 5._

### V4.0 Breaking Changes

- **New parameter type**: `prClipAngle` now accepts a normal numeric value rather than a `Maybe`. To indicate antimeridian cutting supply a 0 rather than `Nothing`.

- **New parameter type**: `leValues` now takes `DataValues` (allowing numbers, strings, dates and Booleans) rather than a more limited set of (now removed) `LegendValues`. To update older code, replace `leValues (leNums [1,2,3]) with leValues (nums [1,2,3])`.

- **New parameter type**: `seToggle` for determining how repeated interaction selections should behave, now takes a more typesafe `TogglePredicate` rather than string. See the table below for their replacements:

  | Old version                  | New version                           |
  | ---------------------------- | ------------------------------------- |
  | `seToggle "false"`           | `seToggle tpFalse`                    |
  | `seToggle "true"`            | `seToggle tpShiftKey`                 |
  | `seToggle "event.shiftKey"`  | `seToggle tpShiftKey`                 |
  | `seToggle "event.ctrlKey"`   | `seToggle tpCtrlKey`                  |
  | `seToggle "event.altKey"`    | `seToggle tpAltKey`                   |
  | `seToggle "some expression"` | `seToggle (tpExpr "some expression")` |

- **Removed exposed type**: Font weight specification has been rationalised so that `FontWeight` type variants `Bold`, `Bolder`, `Lighter`, `Normal`, `W100`, `W200` etc. are no longer exposed and replaced with equivalent functions `fwBold`, `fwBolder`, `fwLighter`, `fwNormal` and `fwValue`.

- **Removed** redundant or older deprecated legend configuration options: `lecoGradientWidth` and `lecoGradientHeight` ( replaced with `lecoGradientLength`); `lecoEntryPadding` (replaced with `lecoRowPadding` and `lecoColPadding`); `lecoGradientLabelBaseline` (replaced with `lecoLabelBaseline`); `lecoShortTimeLabels` (all time labels short by default).

- **Removed** older deprecated `scDomainMid`.

- **Removed** redundant `sacoBarBandPaddingOuter` and `sacoRectBandPaddingOuter`: use `sacoBandPaddingOuter` instead (VL5.0).

- **Removed** `racoSymbol` for configuring default categorical symbols as it was previously incorrect (and ineffective). Use `racoSymbols` which takes a list of symbols instead.

### V4.0 Additions

#### New Parameter and expression model

- `params` and associated `param`, `paBind`, `paBindings`, `paBindScales`, `paBindLegend`, `paSelect`, `paExpr`, `paValue` and `paValues` functions for specifying top-level parameters for use within a spec (VL5.0).

- `bParam` to convert a parameter value into a `BooleanOp` for logical composition.

##### Parameter Transforms

The following new functions transform a literal parameter provided to a function into one that instead evaluates a given expression to generate that parameter.

For example where you might provide

```elm
bar [ maOpacity 0.6 ]
```

you can provide a [Vega-Lite named parameter](https://vega.github.io/vega-lite/docs/parameter.html) to be evaluated instead:

```elm
bar [ maOpacity |> maNumExpr "myParam" ]
```

- `axBooExpr` / `axcoBooExpr` for providing expressions that evaluate to Boolean axis properties (VL5.0).

- `axNumExpr` / `axcoNumExpr` for providing expressions that evaluate to numeric axis properties or configuration. (VL5.0).

- `axNumsExpr` / `axcoNumsExpr` for providing expressions that evaluate to a list of numeric axis (dash) properties or configuration (VL5.0).

- `axStrExpr` / `axcoNumsExpr` for providing expressions that evaluate to string axis properties or configuration (VL5.0).

- `coBooExpr` for providing expressions that evaluate to Boolean top-level configuration properties (VL5.0).

- `coStrExpr` for providing expressions that evaluate to string top-level configuration properties (VL5.0).

- `doNumExpr` for providing expressions that evaluate to numeric scale domain properties (VL5.0).

- `hdNumExpr` for providing expressions that evaluate to numeric facet header properties (VL5.0).

- `hdStrExpr` for providing expressions that evaluate to string facet header properties (VL5.0).

- `leNumExpr` / `lecoNumExpr` for providing expressions that evaluate to numeric legend properties or configuration (VL5.0).

- `leNumsExpr` / `lecoNumsExpr` for providing expressions that evaluate to a list of numeric legend (dash) properties or configuration (VL5.0).

- `leStrExpr` / `lecoStrExpr` for providing expressions that evaluate to string legend properties or configuration (VL5.0).

- `maBooExpr` for providing expressions that evaluate to Boolean mark properties (VL5.0).

- `maNumExpr` for providing expressions that evaluate to numeric mark properties (VL5.0).

- `maNumsExpr` for providing expressions that evaluate to a list of numeric mark (dash) properties (VL5.0).

- `maStrExpr` for providing expressions that evaluate to string mark properties (VL5.0).

- `paNumExpr` for providing expressions that evaluate to numeric padding properties (VL5.0).

- `prNumExpr` for providing expressions that evaluate to numeric projection properties (VL5.0).

- `raNumExpr` for providing expressions that evaluate to numeric scale range properties (VL5.0).

- `scBooExpr` / `sacoBooExpr` for providing expressions that evaluate to Boolean scale properties or configuration (VL5.0).

- `scNumExpr` / `sacoNumExpr` for providing expressions that evaluate to numeric scale properties or configuration (VL5.0).

- `tiNumExpr` / `ticoNumExpr` for providing expressions that evaluate to numeric title properties or configuration (VL5.0).

- `tiStrExpr` / `ticoStrExpr` for providing expressions that evaluate to string title properties or configuration (VL5.0).

- `vbNumExpr` / `vicoNumExpr` for providing expressions that evaluate to numeric view background properties or configuration (VL5.0).

- `vbNumsExpr` / `vicoNumsExpr` for providing expressions that evaluate to a list of numeric view background properties or configuration (VL5.0).

- `vbStrExpr` / `vicoStrExpr` for providing expressions that evaluate to Maybe String view background properties or configuration (VL5.0).

- `vicoBooExpr` for providing expressions that evaluate to a Boolean view background configuration (VL5.0).

##### Non-literal parameter expressions

Used for providing parameter expressions that evaluate to non-literals.

For example, where you might provide

```elm
point [ maShape symSquare ]
```

you can provide a [Vega-Lite named parameter](https://vega.github.io/vega-lite/docs/parameter.html) that evaluates to an appropriate value instead:

```elm
point [ maShape (symExpr "myParam") ]
```

- `anExpr` (text anchoring), `arExpr` (Aria accessibility), `axLabelBoundExpr` / `axcoLabelBoundExpr` (label boundary clipping), `backgroundExpr` (background colour), `bmExpr` (blend mode), `caExpr` (stroke cap style), `clipRectExpr` (clipping extent), `cuExpr`(cursor style), `datumExpr` / `dataExpr` (data from expression), `doDtsExpr`, `doMaxDt`, `doMinDt` (domain timestamp boundaries), `fwExpr` (font weight), `haExpr` (horizontal alignment), `joExpr` (stroke join style), `miExpr` (mark interpolation type), `niExpr` (nice tick intervals), `osExpr` (overlap strategy for axis labels), `paEdgesExpr` (padding on a per-edge basis), `prCenterExpr` (projection center), `prExpr` (projection type), `prParallelsExpr` (conic projection standard parallels), `prRotateExpr` (projection rotation), `prTranslateExpr` (projection translation), `racoSymbols` / `racoSymbolsExpr` (symbols for default scales), `raExprs` (range elements), `scDomainExpr` (domain scaling), `scSchemeExpr` (colour schemes), `siExpr`(side), `symExpr` (shape symbol), `tdExpr`(text direction), `tfExpr` (title frame) and `titleExpr` (top-level title). (VL4.16 to VL 5.1).

#### New selection model

- `ipRange`, `ipSelect`, `ipCheckbox` etc. for input elements as parameters.

- `fiSelectionEmpty` for filtering with default empty result.

- `TogglePredicate` and associated functions `tpFalse`, `tpExpr`, `tpShiftKey`, `tpCtrlKey` and `tpAltKey` for typesafe toggling of selections.

#### Simplified conditional encoding

- `mCondition` (and its `o`, `t` and `h` equivalents) that takes a list of `Predicate`s and associated encodings for testing. A predicate can be either a parameter or a test (via new functions `prParam`, `prParamEmpty` and `prTest`) (VL5.0).

#### Data functions

- `daConcat`, `dataObject`, `dataObjects`, `datumArray` and `dataArrays` for creating typesafe nested and mixed data values (in support of the VL5 interaction model).

- `inDatumOptions` / `inDataOptions` for non-string input options (numeric values, lists etc.)

#### Other new or previously missing VL functions

- `axcoOffset` and `axcoLabelOffset` for configuring axis spacing.

- `axcoStyle` for named axis configuration styles.

- `axTickBand` / `axcoTickBand` and associated `tbCenter`, `tbExtent` and `tbExpr` for aligning axis ticks and grids with band scales.

- `axTickCap` / `axcoTickCap` for axis tick capping style.

- `axTitleLineHeight` for multi-line axis titles.

- `axTranslate` / `axcoTranslate` for axis translation.

- `coLocale` and associated functions `loDecimal`, `loThousands`, `loGrouping`, `loCurrency`, `loNumerals`, `loPercent`, `loMinus`, `loNan`, `loDateTime`, `loDate`, `loTime`, `loPeriods`, `loDay`, `loShortDays`, `loMonths` and `loShortMonths` for specifying locale defaults (VL5.1).

- `lecoDirection`, `lecoGradientLength`, `lecoGradientHorizontalMaxLength`, `lecoGradientHorizontalMinLength`, `lecoGradientVerticalMaxLength`, `lecoGradientVerticalMinLength`, `leGradientOpacity`/`lecoGradientOpacity`, `lecoGradientThickness`, `leLabelFontStyle`/`lecoLabelFontStyle`, `leLabelFontWeight`/`lecoLabelFontWeight`, `leSymbolOpacity`/`lecoSymbolOpacity`, `leSymbolOffset`, `leTitleFontStyle`/`lecoTitleFontStyle`, `lecoNoTitle`, `leTitleAnchor` / `lecoTitleAnchor`, `leTitleLineHeight`, `leTitleOpacity`/`lecoTitleOpacity`, `lecoX` and `lecoY` for legend settings.

- `maPadAngle` for padding arc segments; `maUrl` for image url; `maWidthBand` and `maHeightBand` for specifying dimensions relative to band size.

- `pBandPosition` to replace now deprecated `pBand` (VL5.0)

- `prFit` for translating and scaling a geo projection to given bounds; `prPointRadius` for geo projection of point symbols; `prParallels` for conic projection standard parallels.

- `tiDx` / `ticoDx` and `tiDy` / `ticoDy` title offset options.

#### Convenience functions

- `jsonToSpec` for conversion of any well-formed JSON string into a Spec. Useful for compact specification of nested data structures and as an 'escape hatch' for direct specification of Vega-Lite via JSON input.

### V4.0 Bug Fixes

- `prClipExtent` now correctly creates two point arrays defining Cartesian clip extent for map projections.

### V4.0 Deprecations

These mostly reflect the new selection and parameter model in Vega-Lite 5.

- `selection` deprecated in favour of `params`.
- `select` deprecated in favour of `param` with `paSelect`.
- `selected` deprecated in favour of `bParam`.
- `selectionName` deprecated in favour of `prParam`
- `blField`, `blChannel` and `blEvent` deprecated in favour of `param` settings.

- `mSelectionCondition` (and their `o`, `t` and `h` equivalents) deprecated in favour of a unified `mCondition` (and their `o`, `t` and `h` equivalents) (VL5.0). Where previously a selection condition would be specified as

  ```elm
  mSelectionCondition (selectionName "mySelection") [ mStr "red" ] [ mStr "black" ]
  ```

  it should now be specified as

  ```elm
  mCondition (prParam "mySelection") [ mStr "red" ] [ mStr "black" ]
  ```

- `mDataCondition` (and its `o`, `t` and `h` equivalents) deprecated in favour of the unified `mCondition` (and its `o`, `t` and `h` equivalents) (VL5.0). Where previously a data-dependent condition would be specified as

  ```elm
  mDataCondition [ ( expr "datum.x == null", [ mStr "grey" ] ) ] [ mStr "black" ]
  ```

  it should now be specified as

  ```elm
  mCondition (prTest (expr "datum.x == null")) [ mStr "grey" ] [ mStr "black" ]
  ```

- Under the VL5 interaction model, input elements (sliders etc.) now bound to parameters, so the following are deprecated, replaced by their 'ip' equivalents: `iRange`, `iCheckbox`, `iRadio`, `iSelect`, `iText`, `iNumber`, `iDate`, `iTime`, `iMonth`, `iWeek`, `iDateTimeLocal`, `iTel`, `iColor`.

- `pBand` deprecated in favour of `pBandPosition` to reflect breaking change in VL5.

- `seBindScales` deprecated in favour of `paBindScales` (VL5.0). Where previously zooming might have been specified as

  ```elm
  selection << select "zoomer" seInterval [ seBindScales ]
  ```

  it should now be specified as

  ```elm
  params << param "zoomer" [ paSelect seInterval [], paBindScales ]
  ```

- `seBindLegend` deprecated in favour of `paBindLegend` (VL5.0). Where previously legend binding might have been specified as

  ```elm
  selection
      << select "mySelection"
          seSingle
          [ seBindLegend [ blField "crimeType", blEvent "dblclick ] ]
  ```

  it should now be specified as

  ```elm
  params
      << param "mySelection"
          [ paSelect sePoint [ seFields [ "crimeType" ] ]
          , paBindLegend "dblclick"
          ]
  ```

- `seSingle` and `seMulti` deprecated in favour of `sePoint` (and with `seToggle tpFalse` for single selection behaviour).

- `seEmpty` deprecated in favour of `prParamEmpty` and `fiSelectionEmpty`.
- `seInit` and `seInitInterval` deprecated in favour of `paValue`.

### V4.0 Other Changes

- Examples updated to use new selection model
- New VL 5 gallery examples
- Various minor updates to documentation and examples

---

## V3.1.0 ➡ V3.1.1

_Patch release that uses `main` rather than `master` GitHub branch. See [github.com/github/renaming](https://github.com/github/renaming)_

---

## V3.0.0 ➡ V3.1.0

### V3.1 Additions

- `rgParams` for extracting regression parameters in the `regression` transform (missed in earlier releases).

### V3.1 Bug Fixes

- `cuNWSEResize` now specifies the correct resizing cursor.

### V3.1 Deprecations

- `lecoShortTimeLabels` deprecated as short time labels are now already the default.

### V3.1 Other Changes

- Minor refactoring and removing of redundant code.

---

## V2.3.0 ➡ V3.0.0

### V3.0 Breaking Changes

- `axTickCount` and `axcoTickCount` now take a `ScaleNice` parameter rather than `Float` so that time intervals may be supplied. Previous code that used `axTickCount 123` should now use `axTickCount (niTickCount 123)` (VL.4.10).

- New position channels `Theta`, `Theta2`, `R` and `R2` for radial positioning (e.g. pie charts). This is technically a breaking change as they are new variants in the exposed `Position` type, although in practice this won't break any existing specifications unless pattern matching against all `Position` variants (VL4.9).

- `hdTitleFontWeight` now correctly uses a `FontWeight` parameter (`Bold`, `W300` etc.) rather than a string. The string version inadvertently slipped through in earlier versions. Any specifications that use a String for the weight can use the equivalent `FontWeight` variant.

- `rgExtent` and `dnExtent` now take two floats as the extent values rather than `DataValue` types. To update previous code replace `(num x0) (num x1)` with the simpler `x0 x1` where `x0` and `x1` are the minimum and maximum numeric values of the extent.

- `key` now creates a field/type object. Previously this incorrectly generated a string rather than object, so while this is a breaking change, there should be no working specs with the old key type. Field name can be specified with `kName` and type with `kQuant`, `kNominal` etc.

- Removed deprecated functions: `axcoShortTimeLabels`, `axcoTickStep`, `axDates`, `axTickStep`, `coAxisX`, `coAxisY`, `coNamedStyle`, `coNamedStyles`, `coStack`, `lookupAs`, `sacoRangeStep`, `sacoTextXRangeStep`, `scBinLinear`, `scRangeStep`, `scSequential`, `vicoWidth` and `vicoHeight`

### V3.0 Additions

- `raField` for setting range values explicitly from a data source (VL4.14).

- `raMin` and `raMax` for setting selected range bounds (VL4.14)

- `doMin`, `doMid`, `doMax`, `doMinDt` and `doMaxDt` for setting selected bounds of a numeric or date-time domain (VL4.14)

- `oDataCondition`, `oSelectionCondition` and `oNum` for conditional ordering (VL4.14).

- Added _week_ and _dayOfYear_ temporal binning options (VL4.13).

- `axDomainDashOffset`, `axGridDashOffset`, `cAxGridDashOffset`, `axTickDashOffset` and `cAxTickDashOffset` dash offset parameters along with their _axco_ configuration equivalents (VL4.13 and VL4.12).

- `dayHours`, `dayHoursMinutes`, `dayHoursMinutesSeconds`, `monthDateHoursMinutes` and `monthDateHoursMinutesSeconds` added as temporal binning options (VL4.12).

- `tDatum` for data-space constants to be encoded with a text channel (VL4.12).

- `axDomainCap` and `axGridCap` for controlling axis baseline and gridline end caps (VL4.12).

- `axDomainDash` and `axcoDomainDash` for controlling axis baseline dash style (VL4.12).

- `coAria` to configure the enabling/disabling ARIA support in SVG output; `maAria` and associated properties `arEnable`, `arDisable` and `arDescription` for setting ARIA support on a per mark basis. `axAria` / `axcoAria`, `leAria` / `lecoAria` and associated properties for setting ARIA support on a per axis and legend basis (VL4.12).

- `coCustomFormatTypes` for enabling/disabling use of registered custom formatters (VL4.11).

- `axcoDisable` and `lecoDisable` to disable axes and legends by default in configuration (VL4.10).

- `mBand` for non-positional band encoding (VL4.10)

- `arc` and `text` mark offset functions `maThetaOffset`, `maTheta2Offset`, `maRadiusOffset` and `maRadius2Offset` (VL4.10).

- `pDatum` for specifying a literal data-driven positioning (VL.4.9).

- `mDatum` for specifying a literal data-driven mark property (VL.4.9).

- `layerFields` and `arLayer` for arranging views in layers using a repeat list of fields (VL4.9).

- `mRepeatDatum` for specifying a set of literal datum values in a repeated view (VL4.9).

- `angle` channel for data-driven rotation of point and text symbols (VL4.9).

- `arc` mark and associated radial mark properties `maInnerRadius`, `maOuterRadius`, `maTheta` and `maTheta2` (VL4.9).

- `maRadiusOffset` for polar offsetting of text marks that have been positioned via `Theta` and `R` (VL 4.9).

- `leTitleOrient` for positioning a title relative to legend content.

- `leSymbolLimit` and `lecoSymbolLimit` for limiting the number of entries in a discrete legend (VL 4.8).

### V3.0 Bug Fixes

- `niInterval` now correctly generates a time unit string rather than `"unit":XXX`.

### V3.0 Deprecations

- `scDomainMid` deprecated in favour of `scDomain (doMid)` to provide consistency with new (VL4.14) `doMin` and `doMax` functions.

### V3.0 Other Changes

- Calling `dataFromRows` or `dataFromColumns` without `dataRow` / `dataColumn` now generates an empty dataset that can be useful for creating annotation layers with literals.

- Removed now redundant measurement type specifications that can instead rely on default measurement types (VL 4.14).

- Minor improvements to the API documentation.

- Additions to tests for new features added since VL 4.8.

- Tests and examples now use vega data V2 with single path to explicit data version.

- New gallery examples.

---

## V2.2.0 ➡ V2.3.0

### V2.3 Additions

- `hdLabelBaseline`, `hdLabelExpr`, `hdLabelFontStyle`, `hdLabelFontWeight`, `hdLabelLineHeight`, `hdLabels`, `hdOrient`, `hdTitleFontStyle` and `hdTitleLineHeight` facet header customisation options (VL 4.8).

- `coAxisXFilter` and `coAxisYFilter` to modify axis configurations to apply only to the X or Y axes (supports changes in VL 4.7)

- `maBlend` and associated `bm` blend mode options for specifying how overlaid colours are combined (VL 4.6).

- `vaLineTop` and `vaLineBottom` for vertical alignment of text marks based on line height (VL 4.6).

- `axLabelLineHeight` and `axcoLabelLineHeight` for setting axis label line height (VL 4.6).

- `opProduct` for aggregation of numeric values by their product (VL 4.6).

- `axFormatAsCustom`, `leFormatAsCustom`, `hdFormatAsCustom` and `tFormatAsCustom` for using registered text formatters (VL 4.6).

- `axTickDash` and `cAxTickDash` for conditional tick dash styles (VL 4.6)

- `cAxLabelOffset` for conditional axis label offsetting (VL 4.5)

- `coAxisDiscrete` and `coAxisPoint` axis configuration options (VL 4.5)

- `sacoXReverse` for configuring right-to-left charts and undeprecated `scReverse` (VL 4.5)

- `axcoLabelExpr` and `axcoTickCount` for configuring default label transformations and tick counts (VL 4.4)

- `axLabelOffset` for offsetting axis labels from their tick marks (VL 4.4).

- `axStyle` and `coAxisStyles` for named style configuration of axis properties (VL 4.4).

- `coMarkStyles` in place of previous `coNamedStyles` for greater naming consistency.

- `tiLineHeight` for setting title line height

- `doSelectionChannel` and `doSelectionField` for projecting selection onto a specific field or channel when scaling a domain.

### V2.3 Deprecations

- `coNamedStyle` and `coNamedStyles` both deprecated in favour of `coMarkStyles`. Provides greater naming consistency with the addition of (VL 4.4) `coAxisStyles`.

- `coAxisX` and `coAxisY` deprecated in favour of the more flexible `coAxisXFilter` and `coAxisYFilter` modifiers. For example, replace `coAxisX [ axcoTitleColor "red" ]` with `coAxis [ axcoTitleColor "red" ] |> coAxisXFilter)`

- `scBinLinear` deprecated in favour of `scLinear` with binning aggregation.

### V2.3 Other Changes

- `maText` now respects multi-line strings.

- Simplified Likert gallery example to use multi-line text literals.

- Providing `hdTitle` with an empty string now generates a JSON null value rather than empty string, to be compatible with schema.

- Replaced now deprecated `coNamedStyle` and `coNamedStyles` with `coMarkStyles` in gallery examples and test.

---

## V2.1.0 ➡ V2.2.0

### V2.2 Additions

- `doUnionWith` for combining fixed and data-driven domains (VL 4.3)
- `coFont` for configuring global font (VL 4.3).
- `strokeDash` and associated `chStrokeDash` encoding channel (VL 4.2)
- `coAxisQuant` and `coAxisTemporal` for configuring quantitative and temporal axes (VL 4.2)
- `timeUnit` can now create objects parameterised with `tuMAxBins` and `tuStep` (VL 4.1).
- `maCornerRadiusEnd` for rounding upper or right corners of bar rectangles (V L4.1).
- `scDomainMid` for setting midpoint in a diverging continuous scale (VL 4.1).
- `cAxLabelPadding` and `cAxTickSize` conditional axis formatting (VL 4.1)
- `smCursor` for setting cursor over selection mark (VL 4.1)
- `vicoCursor` for setting default cursor over view.
- `miLinearClosed` interpolation to form closed polygons (missed exposing this from earlier releases).
- `fAlign`, `fCenter` and `fSpacing` for positioning of sub-plots in faceted views (VL 4).
- `lecoUnselectedOpacity` for setting opacity of unselected interactive legend items (VL 4).
- `ticoLineHeight`, `axcoTitleLineHeight`, `lecoTitleLineHeight` and `maLineHeight` for multi-line text line height configuration (VL 4).
- `vaAlphabetic` for baseline vertical alignment of text marks.
- `maLimit`, `maEllipsis` and `maDir` with `tdLeftToRight` and `tdRightToLeft` for truncating and formatting text marks.
- providing empty lists to the boxplot elements that appear by default (outliers, median, box and rule) now removes them.
- `\n` in a `tStr` string literal now respects multiple-lines in text mark.

### V2.2 Other Changes

- Minor corrections to the API documentation.
- Internal refactor of transform functions that return multiple labelled specs.
- Additions to tests for new VL4.1 features
- Amended examples and tests to conform with the (breaking) changes in the VL4.1 schema.

---

## V2.0.0 ➡ V2.1.0

### V2.1 Additions

- `naturalEarth1` map projection type.

### V2.1 Bug Fixes

- Correct `maxsteps` parameter output of `density` transform (thanks @dougburke for spotting this).

- Correct but in `density` that was incorrectly using value of `dnCounts` for the `dnCumulative` setting (thanks @dougburke for spotting this).

---

## V1.12 ➡ V2.0

Major release supporting Vega-Lite 4.0. Includes a small number of breaking changes that should provide greater flexibility and some simplification of the API.

### V2.0 Breaking Changes

- _`title` now takes a list of optional title properties._
  To update older code, simply add a `[]` as a second parameter to `title`

- _`lookup` now allows naming of individual matched fields and a default for failed lookups_.
  Instead of `lookup "key1" secondaryData "key2" ["field1", "field2"]` use `lookup "key1" secondaryData "key2" (luFields ["field1", "field2"])`. Additional functions `luAs`, `luAsWithDefault`, `luFieldsAs`, `luFieldsAsWithDefault`, `luFields` and `luFieldsWithDefault` provide greater flexibility in naming and default behaviour. It also uses the `Data` type alias as part of its type signature, which is unlikely to impact any use of the API but is technically a breaking change.

- _Replaced `coRemoveInvalid` with `maRemoveInvalid`_.
  To stop filtering of invalid values, this is now specified as a mark property. For example, instead of `configuration (coRemoveInvalid False)`, use `configuration (coMark [ maRemoveInvalid False ])`.

- _Tooltips are now disabled by default_ (via change in Vega-lite).
  Can be enabled either via an explicit `tooltip` channel, or by setting `maTooltip ttEncoding`.

- _Background is now white by default_ (via a change in Vega-lite).
  Previously backgrounds were transparent. Can mimic previous behaviour by adding a transparent configuration `configuration (coBackground "rgba(0,0,0,0)")`

- _`axValues` now takes `DataValues` (allowing numbers, strings, dates and Booleans) rather than just a list of floats._
  To update older code, replace `axValues [1,2,3] with axValues (nums [1,2,3])`.

- _Removed (invalid) functions `mImpute` and `dImpute`._

- _`opArgMin` and `opArgMax` now require a `Maybe String` parameter._
  To update older code, replace `opArgMin` with `opArgMin Nothing`.

- _Overlap strategy constructors hidden._
  Should use `osNone`, `osGreedy` and `osParity` instead. These were always available, but the constructors themselves had been inadvertently exposed, so it is unlikely to require a change in practice.

- _`columns` now takes an `int` rather than `Maybe int`._
  To update older code, replace `columns (Just n)` with `columns n` and `columns Nothing` with `columns 0`.

- `Position` custom type has extra variants `XError`, `XError2`, `YError` and `YError2`. Technically a breaking change but unlikely to affect existing specifications unless pattern matching against `Position`.

### V2.0 Additions

#### Transforms

- `density` (and associated `dn` density property functions) for KDE transforms.

`loess` (and associated `ls` loess property functions) for locally-estimated scatterplot smoothing.

- `pivot` (and associated `pi` pivot property functions) for data shaping.

- `quantile` (and associated `qt` quantile property functions) for computing quantiles from a distribution.

- `regression` (and associated `rg` regression property functions) for regression modelling.

- `fiOp` for converting filters into `BooleanOp` and therefore allowing Boolean composition of filter functions.

- `fiOpTrans` for combining an inline data transformation with a filter and converting to a `BooleanOp`. Especially useful when filtering temporal data that require aggregating with `mTimeUnit`.

#### Marks and Mark Properties

- `image` mark and associated `url` channel and `maAspect` mark property for displaying images.

- `mSort` for sorting by mark properties like `color`.

- `maColorGradient`, `maFillGradient` and `maStrokeGradient` (and associated `gr` gradient property functions) for gradient-based colouring.

- `maCornerRadius`, `maCornerRadiusBottomLeft`, `maCornerRadiusBottomRight`, `maCornerRadiusTopLeft` and `maCornerRadiusTopRight` for rounding a rectangle mark.

- `maWidth` and `maHeight` for explicitly setting mark width and height.

- `pBand` for setting position/size relative to a band width.

- Support empty strings for `maFill` and `maStroke` to indicate absence of fill or stroke.

#### Selections

- `lookupSelection` for lookups that rely on an interactive selection of data.

- `seBindLegend` and associated property functions `blField`, `blChannel` and `blEvent` for creating interactive legends.

- `seInitInterval` for initialising an interval selection's extent.

- `biSelectionExtent` for basing a bin extent on an interactive selection.

#### Configuration

- New title configuration options: `ticoFontStyle`, `ticoFrame`, `ticoStyle`, `ticoZIndex`, `ticoSubtitleColor`, `ticoSubtitleFont`, `ticoSubtitleFontSize`, `ticoSubtitleFontStyle`, `ticoSubtitleFontWeight`, `ticoSubtitleLineHeight` and `ticoSubtitlePadding`.

- `coConcat` for configuring concatenations (`cocoSpacing` and `cocoColumns`).

- `vicoStep` for configuring default step size for discrete x and y discrete fields.

- `vicoContinuousWidth`, `vicoDiscreteWidth`, `vicoContinuousHeight` and `vicoDiscreteHeight` for dimension configuration depending on type of data.

- `vicoBackground` for configuring default single view plot area background appearance.

#### Titles and Axes

- `title` and component titles (axis title, legend title etc.) can now be formatted over multiple lines with `\n` or `"""` multi-line strings.

- `axDataCondition` and associated `cAx` property functions for conditional axis formatting.

- Additional axis formatting options: `axGridColor`, `axGridOpacity`, `axGridWidth`, `axLabelExpr`, `axLabelFontStyle`, `axLabelSeparation`, `axTitleFontStyle` and `axTitleAnchor` along with extra config options `axcoLabelFontStyle`, `axcoLabelSeparation`, `axcoTitleFontStyle` and `axcoTitleAnchor`.

- New title option `tiSubtitle` for specifying secondary title text. Can be styled via new functions `tiSubtitleColor`, `tiSubtitleFont`, `tiSubtitleFontSize`, `tiSubtitleFontStyle`, `tiSubtitleFontWeight`, `tiSubtitleLineHeight` and `tiSubtitlePadding`.

#### Data

- `noData` for preventing inheritance of parent data source in a specification.

- `nullValue` for explicitly setting data values to null.

- `dtMonthNum` for referencing a month by its numeric value.

- `tStr` for string literals in a text encoding channel.

#### Other

- Convenience functions for setting a channel's measurement type. `pNominal`, `pOrdinal`, `pQuant`, `pTemporal` and `pGeo` equivalent to `pMType Nominal`, `pMType Ordinal` etc. Similar functions for `m` (mark), `t` (text), `h` (hyperlink), `o` (order) `d` (detail) and `f` (facet) channels.

- `scAlign` for aligning marks within a range.

- `widthStep` and `heightStep` for setting the width/height of a discrete x or y field (e.g. individual bars in a bar chart).

- `widthOfContainer` and `heightOfContainer` for responsive sizing.

- `asFitX` and `asFitY` for autosizing in one dimension only.

- Additional symbols `symTriangleLeft`, `symTriangleRight`, `symTriangle`, `symArrow`, `symWedge` and `symStroke` and `mSymbol` convenience function for symbol literals.

- `equalEarth` map projection type.

- `key` channel for binding with Vega View API.

### V2.0 Deprecations

- `axcoShortTimeLabels` deprecated as this is the default since VL4.

- `axDates` deprecated in favour of new more flexible `axValues`.

- `lookupAs` deprecated in favour of `lookup` with `luAs`.

- `scReverse` deprecated in favour of `mSort` (while `scReverse` works, it is not part of the Vega-Lite schema).

- `scRangeStep`, deprecated in favour of `widthStep` and `heightStep`.

- `sacoRangeStep` and `sacoTextXRangeStep` deprecated in favour of `vicoStep`.

- `vicoWidth` and `vicoHeight` deprecated in favour of `vicoContinuousWidth`, `vicoDiscreteWidth`, `vicoContinuousHeight` and `vicoDiscreteHeight`.

- `coStack` deprecated as it is unnecessary.

### V2.0 Bug Fixes

- `coFieldTitle` now correctly creates a 'functional' label.

- Overlap strategy `osNone` now evaluates correctly.

- Field definitions inside `mDataCondition` now handled correctly (previously only worked with value definitions).

- Empty grid/stroke dash list now correctly generates a `null` value rather than empty array in JSON spec (while an empty array works, it is not permitted by the Vega-Lite schema).

### V2.0 Other Changes

- Improvements to the API documentation with a larger number of inline examples.

- New gallery examples reflecting additions to the Vega-Lite example set.

- Numerous minor gallery example updates to reflect API changes and provide more idiomatic specifications.

- Additional tests for new functionality.
