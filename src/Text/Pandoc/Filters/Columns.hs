{-|
Module      : Columns
Description : Pandoc filter to support columns in Markdown.
Copyright   : (c) Amy de Buitléir, 2020-2022
License     : BSD--3
Maintainer  : amy@nualeargais.ie
Stability   : experimental
Portability : POSIX

See <https://github.com/mhwombat/pandoc-linear-table> for information
on how to use this filter.
-}

{-# LANGUAGE OverloadedStrings #-}
module Text.Pandoc.Filters.Columns
  (
    transform,
    formatColumns
  ) where

import Text.Pandoc      qualified as P
import Text.Pandoc.Walk (walk)


-- | A transformation that can be used with Hakyll.
transform :: P.Pandoc -> P.Pandoc
transform = walk formatColumns

formatColumns :: P.Block -> P.Block
formatColumns (P.Div attr@(_,["columns"],_) bs)
  = P.Table attr defaultTableCaption colSpecs
                    defaultTableHeader [body]
                    defaultTableFooter
  where body = blocksToTableBody bs
        colSpecs = map (const defaultColSpec) bs
formatColumns b = b

blocksToTableBody :: [P.Block] -> P.TableBody
blocksToTableBody bs = P.TableBody P.nullAttr (P.RowHeadColumns 0) [] [row]
  where row = blocksToTableRow bs

blocksToTableRow :: [P.Block] -> P.Row
blocksToTableRow = P.Row P.nullAttr . map blockToCell

blockToCell :: P.Block -> P.Cell
blockToCell b = P.Cell P.nullAttr P.AlignDefault (P.RowSpan 1) (P.ColSpan 1) [b]

defaultColSpec :: P.ColSpec
defaultColSpec = (P.AlignDefault, P.ColWidthDefault)

defaultTableCaption :: P.Caption
defaultTableCaption = P.Caption Nothing []

defaultTableHeader :: P.TableHead
defaultTableHeader = P.TableHead P.nullAttr []

defaultTableFooter :: P.TableFoot
defaultTableFooter = P.TableFoot P.nullAttr []
