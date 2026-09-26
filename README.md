# Local class field theory in Lean 4.35.0-rc2

This repository includes the complete ClassFieldTheory source bundle and
presents its finite norm-quotient form of local class field theory. The source
corresponds to [ClassFieldTheory commit 7713795234690681b4406ae198b07aa95e82716a](https://github.com/n-yamaguchi-0729/ClassFieldTheory/tree/7713795234690681b4406ae198b07aa95e82716a).

The compared declaration is
`ClassFieldTheory.finiteAbelianLocalReciprocity_quotient`. For a finite
abelian extension `L / K` of a nonarchimedean local field, it states

```text
Kˣ / N_{L/K}(Lˣ) ≃ₜ* Gal(L/K).
```

Here `≃ₜ*` is an isomorphism of topological multiplicative groups. The
Mathlib-only Challenge defines the field norm, its image subgroup, and the
quotient; the Solution imports the completed proof from the included source.

## Additional proved results

The same CFT development also proves:

- a continuous surjective finite Artin map with field-norm kernel in
  [`FiniteAbelianLocalReciprocity.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalReciprocity.lean);
- a coherent family with norm kernels, tower compatibility, and arithmetic
  Frobenius normalization in
  [`FiniteAbelianLocalReciprocityFamilyArithmeticFrobenius.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalReciprocityFamilyArithmeticFrobenius.lean);
- uniqueness of the normalized coherent family in
  [`FiniteAbelianLocalReciprocityFamilyExt.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalReciprocityFamilyExt.lean);
- the local existence/classification theorem as an order isomorphism in
  [`FiniteAbelianLocalExistenceOrderIso.lean`](Lean4/ClassFieldTheory/Theorems/LocalClassFieldTheory/FiniteAbelianLocalExistenceOrderIso.lean).

The theorem placeholder in `Challenge.lean` is deliberate; `Solution.lean`
imports the completed proof.

## Authorship

Astra GPT-6 Codex assisted with Lean development, statement review, and
preparation of this submission interface. Naganori Yamaguchi is the
human author and responsible maintainer.

Licensed under Apache-2.0.

## Pinned Mathlib definitions behind the compared statement

The Challenge uses [Mathlib commit `065356127b1dc0016f66b7283ce0ce2c4055aa55`](https://github.com/leanprover-community/mathlib4/tree/065356127b1dc0016f66b7283ce0ce2c4055aa55), as recorded in `lake-manifest.json`. The following are unmodified excerpts of the relevant Lean definitions at that commit. Surrounding implicit parameters are visible in the linked source files. These excerpts explain the imported hypotheses and the two topologies in the theorem; they add no assumptions or declarations to the Challenge.

**Local-field hypothesis.** [`IsNonarchimedeanLocalField`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/NumberTheory/LocalField/Basic.lean#L45-L49) requires the given topology on `K` to be valuative, locally compact, and nontrivial:

```lean
class IsNonarchimedeanLocalField
    (K : Type*) [Field K] [ValuativeRel K] [TopologicalSpace K] : Prop extends
  IsValuativeTopology K,
  LocallyCompactSpace K,
  ValuativeRel.IsNontrivial K
```

The underlying [`ValuativeRel`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/RingTheory/Valuation/ValuativeRel/Basic.lean#L73-L82) is a total, compatible valuation preorder. [`LocallyCompactSpace`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/Topology/Defs/Filter.lean#L323-L326) requires compact neighborhoods inside every neighborhood of each point:

```lean
class ValuativeRel (R : Type*) [Semiring R] where
  /-- The valuation less-equal operator arising from `ValuativeRel`. -/
  vle : R → R → Prop
  vle_total (x y) : vle x y ∨ vle y x
  vle_trans {z y x} : vle x y → vle y z → vle x z
  vle_add {x y z} : vle x z → vle y z → vle (x + y) z
  mul_vle_mul_left {x y} (h : vle x y) (z) : vle (x * z) (y * z)
  vle_mul_cancel {x y z} : ¬ vle z 0 → vle (x * z) (y * z) → vle x y
  not_vle_one_zero : ¬ vle 1 0
  vle_mul_comm {x y} : vle (x * y) (y * x)

class LocallyCompactSpace (X : Type*) [TopologicalSpace X] : Prop where
  /-- In a locally compact space,
  every neighbourhood of every point contains a compact neighbourhood of that same point. -/
  local_compact_nhds : ∀ (x : X), ∀ n ∈ 𝓝 x, ∃ s ∈ 𝓝 x, s ⊆ n ∧ IsCompact s
```

The [valuative-topology condition](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/Topology/Algebra/ValuativeRel/ValuativeTopology.lean#L58-L60) determines neighborhoods using valuation balls, and [nontriviality](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/RingTheory/Valuation/ValuativeRel/Basic.lean#L927-L929) excludes a value group containing only zero and one:

```lean
class IsValuativeTopology [TopologicalSpace R] where
  mem_nhds_iff {s : Set R} {x : R} : s ∈ 𝓝 (x : R) ↔
    ∃ γ : (ValueGroupWithZero R)ˣ, (x + ·) '' { z | valuation _ z < γ } ⊆ s

class IsNontrivial where
  condition : ∃ γ : ValueGroupWithZero R, γ ≠ 0 ∧ γ ≠ 1
```

**Abelian-Galois hypothesis.** [`IsAbelianGalois`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/FieldTheory/Galois/Abelian.lean#L25-L26) requires a Galois extension with commutative Galois group. [`IsGalois`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/FieldTheory/Galois/Basic.lean#L57-L59) supplies separability and normality. The theorem separately assumes `FiniteDimensional K L`.

```lean
class IsAbelianGalois (K L : Type*) [Field K] [Field L] [Algebra K L] : Prop extends
  IsGalois K L, IsMulCommutative Gal(L/K)

class IsGalois : Prop where
  [to_isSeparable : Algebra.IsSeparable F E]
  [to_normal : Normal F E]
```

The inherited [`IsMulCommutative`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/Algebra/Group/Semigroup.lean#L174-L175) condition says multiplication in `Gal(L/K)` is commutative:

```lean
class IsMulCommutative (M : Type*) [Mul M] : Prop where
  is_comm : Std.Commutative (α := M) (· * ·)
```

**Topologies and equivalence.** The topology on `Kˣ` is [induced by its embedding into `K × K`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/Topology/Algebra/Constructions.lean#L101-L102). The topology on `Kˣ / N_{L/K}(Lˣ)` is the [quotient-group topology](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/Topology/Algebra/Group/Quotient.lean#L32-L33), whose [underlying quotient topology](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/Topology/Constructions.lean#L58-L60) is coinduced along the quotient map:

```lean
instance instTopologicalSpaceUnits : TopologicalSpace Mˣ :=
  TopologicalSpace.induced (embedProduct M) inferInstance

instance instTopologicalSpace (N : Subgroup G) : TopologicalSpace (G ⧸ N) :=
  instTopologicalSpaceQuotient

instance instTopologicalSpaceQuotient {s : Setoid X} [t : TopologicalSpace X] :
    TopologicalSpace (Quotient s) :=
  coinduced Quotient.mk' t
```

The Galois group has the [Krull topology](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/FieldTheory/KrullTopology.lean#L131-L135) induced by fixing subgroups of finite intermediate extensions; it is [discrete when `L/K` is finite-dimensional](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/FieldTheory/KrullTopology.lean#L247-L251). The notation `≃ₜ*` is [`ContinuousMulEquiv`](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/Mathlib/Topology/Algebra/ContinuousMonoidHom.lean#L307-L319), combining a multiplicative equivalence and a homeomorphism, so both directions are continuous:

```lean
instance krullTopology (K L : Type*) [Field K] [Field L] [Algebra K L] :
    TopologicalSpace Gal(L/K) :=
  GroupFilterBasis.topology (galGroupBasis K L)

structure ContinuousMulEquiv [Mul G] [Mul H] extends G ≃* H, G ≃ₜ H
```

Mathlib is distributed under [Apache-2.0](https://github.com/leanprover-community/mathlib4/blob/065356127b1dc0016f66b7283ce0ce2c4055aa55/LICENSE), the same license provided in this repository. No excerpt above is modified. The original source-file copyright notices are retained here:

| Excerpt source in `Mathlib/` | Original copyright notice |
| --- | --- |
| `NumberTheory/LocalField/Basic.lean`, `FieldTheory/Galois/Abelian.lean` | Copyright (c) 2025 Andrew Yang. All rights reserved. |
| `RingTheory/Valuation/ValuativeRel/Basic.lean` | Copyright (c) 2025 Adam Topaz. All rights reserved. |
| `Topology/Algebra/ValuativeRel/ValuativeTopology.lean` | Copyright (c) 2026 Jiedong Jiang. All rights reserved. |
| `Topology/Defs/Filter.lean`, `Topology/Algebra/Group/Quotient.lean`, `Topology/Constructions.lean` | Copyright (c) 2017 Johannes Hölzl. All rights reserved. |
| `FieldTheory/Galois/Basic.lean` | Copyright (c) 2020 Thomas Browning, Patrick Lutz. All rights reserved. |
| `Algebra/Group/Semigroup.lean` | Copyright (c) 2014 Jeremy Avigad. All rights reserved. |
| `Topology/Algebra/Constructions.lean` | Copyright (c) 2021 Nicolò Cavalleri. All rights reserved. |
| `FieldTheory/KrullTopology.lean` | Copyright (c) 2022 Sebastian Monnet. All rights reserved. |
| `Topology/Algebra/ContinuousMonoidHom.lean` | Copyright (c) 2022 Thomas Browning. All rights reserved. |
