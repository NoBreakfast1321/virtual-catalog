// uuidv7@1.0.2 downloaded from https://ga.jspm.io/npm:uuidv7@1.0.2/dist/index.js

/**
 * uuidv7: A JavaScript implementation of UUID version 7
 *
 * Copyright 2021-2024 LiosK
 *
 * @license Apache-2.0
 * @packageDocumentation
 */
const t="0123456789abcdef";class UUID{
/** @param bytes - The 16-byte byte array representation. */
constructor(t){this.bytes=t}static ofInner(t){if(t.length!==16)throw new TypeError("not 128-bit length");return new UUID(t)}
/**
     * Builds a byte array from UUIDv7 field values.
     *
     * @param unixTsMs - A 48-bit `unix_ts_ms` field value.
     * @param randA - A 12-bit `rand_a` field value.
     * @param randBHi - The higher 30 bits of 62-bit `rand_b` field value.
     * @param randBLo - The lower 32 bits of 62-bit `rand_b` field value.
     * @throws RangeError if any field value is out of the specified range.
     */static fromFieldsV7(t,e,r,n){if(!Number.isInteger(t)||!Number.isInteger(e)||!Number.isInteger(r)||!Number.isInteger(n)||t<0||e<0||r<0||n<0||t>0xffffffffffff||e>4095||r>1073741823||n>4294967295)throw new RangeError("invalid field value");const i=new Uint8Array(16);i[0]=t/2**40;i[1]=t/2**32;i[2]=t/2**24;i[3]=t/65536;i[4]=t/256;i[5]=t;i[6]=112|e>>>8;i[7]=e;i[8]=128|r>>>24;i[9]=r>>>16;i[10]=r>>>8;i[11]=r;i[12]=n>>>24;i[13]=n>>>16;i[14]=n>>>8;i[15]=n;return new UUID(i)}static parse(t){var e,r,n,i;let s;switch(t.length){case 32:s=(e=/^[0-9a-f]{32}$/i.exec(t))===null||e===void 0?void 0:e[0];break;case 36:s=(r=/^([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{12})$/i.exec(t))===null||r===void 0?void 0:r.slice(1,6).join("");break;case 38:s=(n=/^\{([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{12})\}$/i.exec(t))===null||n===void 0?void 0:n.slice(1,6).join("");break;case 45:s=(i=/^urn:uuid:([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{12})$/i.exec(t))===null||i===void 0?void 0:i.slice(1,6).join("");break;default:break}if(s){const t=new Uint8Array(16);for(let e=0;e<16;e+=4){const r=parseInt(s.substring(2*e,2*e+8),16);t[e+0]=r>>>24;t[e+1]=r>>>16;t[e+2]=r>>>8;t[e+3]=r}return new UUID(t)}throw new SyntaxError("could not parse UUID string")}
/**
     * @returns The 8-4-4-4-12 canonical hexadecimal string representation
     * (`0189dcd5-5311-7d40-8db0-9496a2eef37b`).
     */toString(){let e="";for(let r=0;r<this.bytes.length;r++){e+=t.charAt(this.bytes[r]>>>4);e+=t.charAt(this.bytes[r]&15);r!==3&&r!==5&&r!==7&&r!==9||(e+="-")}return e}
/**
     * @returns The 32-digit hexadecimal representation without hyphens
     * (`0189dcd553117d408db09496a2eef37b`).
     */toHex(){let e="";for(let r=0;r<this.bytes.length;r++){e+=t.charAt(this.bytes[r]>>>4);e+=t.charAt(this.bytes[r]&15)}return e}
/** @returns The 8-4-4-4-12 canonical hexadecimal string representation. */toJSON(){return this.toString()}getVariant(){const t=this.bytes[8]>>>4;if(t<0)throw new Error("unreachable");if(t<=7)return this.bytes.every((t=>t===0))?"NIL":"VAR_0";if(t<=11)return"VAR_10";if(t<=13)return"VAR_110";if(t<=15)return this.bytes.every((t=>t===255))?"MAX":"VAR_RESERVED";throw new Error("unreachable")}getVersion(){return this.getVariant()==="VAR_10"?this.bytes[6]>>>4:void 0}clone(){return new UUID(this.bytes.slice(0))}equals(t){return this.compareTo(t)===0}compareTo(t){for(let e=0;e<16;e++){const r=this.bytes[e]-t.bytes[e];if(r!==0)return Math.sign(r)}return 0}}class V7Generator{constructor(t){this.timestamp=0;this.counter=0;this.random=t!==null&&t!==void 0?t:getDefaultRandom()}generate(){return this.generateOrResetCore(Date.now(),1e4)}generateOrAbort(){return this.generateOrAbortCore(Date.now(),1e4)}
/**
     * Generates a new UUIDv7 object from the `unixTsMs` passed, or resets the
     * generator upon significant timestamp rollback.
     *
     * This method is equivalent to {@link generate} except that it takes a custom
     * timestamp and clock rollback allowance.
     *
     * @param rollbackAllowance - The amount of `unixTsMs` rollback that is
     * considered significant. A suggested value is `10_000` (milliseconds).
     * @throws RangeError if `unixTsMs` is not a 48-bit positive integer.
     */generateOrResetCore(t,e){let r=this.generateOrAbortCore(t,e);if(r===void 0){this.timestamp=0;r=this.generateOrAbortCore(t,e)}return r}
/**
     * Generates a new UUIDv7 object from the `unixTsMs` passed, or returns
     * `undefined` upon significant timestamp rollback.
     *
     * This method is equivalent to {@link generateOrAbort} except that it takes a
     * custom timestamp and clock rollback allowance.
     *
     * @param rollbackAllowance - The amount of `unixTsMs` rollback that is
     * considered significant. A suggested value is `10_000` (milliseconds).
     * @throws RangeError if `unixTsMs` is not a 48-bit positive integer.
     */generateOrAbortCore(t,e){const r=4398046511103;if(!Number.isInteger(t)||t<1||t>0xffffffffffff)throw new RangeError("`unixTsMs` must be a 48-bit positive integer");if(e<0||e>0xffffffffffff)throw new RangeError("`rollbackAllowance` out of reasonable range");if(t>this.timestamp){this.timestamp=t;this.resetCounter()}else{if(!(t+e>=this.timestamp))return;this.counter++;if(this.counter>r){this.timestamp++;this.resetCounter()}}return UUID.fromFieldsV7(this.timestamp,Math.trunc(this.counter/2**30),this.counter&2**30-1,this.random.nextUint32())}resetCounter(){this.counter=this.random.nextUint32()*1024+(this.random.nextUint32()&1023)}generateV4(){const t=new Uint8Array(Uint32Array.of(this.random.nextUint32(),this.random.nextUint32(),this.random.nextUint32(),this.random.nextUint32()).buffer);t[6]=64|t[6]>>>4;t[8]=128|t[8]>>>2;return UUID.ofInner(t)}}const getDefaultRandom=()=>{if(typeof crypto!=="undefined"&&typeof crypto.getRandomValues!=="undefined")return new BufferedCryptoRandom;if(typeof UUIDV7_DENY_WEAK_RNG!=="undefined"&&UUIDV7_DENY_WEAK_RNG)throw new Error("no cryptographically strong RNG available");return{nextUint32:()=>Math.trunc(Math.random()*65536)*65536+Math.trunc(Math.random()*65536)}};class BufferedCryptoRandom{constructor(){this.buffer=new Uint32Array(8);this.cursor=65535}nextUint32(){if(this.cursor>=this.buffer.length){crypto.getRandomValues(this.buffer);this.cursor=0}return this.buffer[this.cursor++]}}let e;
/**
 * Generates a UUIDv7 string.
 *
 * @returns The 8-4-4-4-12 canonical hexadecimal string representation
 * ("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx").
 */const uuidv7=()=>uuidv7obj().toString();const uuidv7obj=()=>(e||(e=new V7Generator)).generate()
/**
 * Generates a UUIDv4 string.
 *
 * @returns The 8-4-4-4-12 canonical hexadecimal string representation
 * ("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx").
 */;const uuidv4=()=>uuidv4obj().toString();const uuidv4obj=()=>(e||(e=new V7Generator)).generateV4();export{UUID,V7Generator,uuidv4,uuidv4obj,uuidv7,uuidv7obj};

